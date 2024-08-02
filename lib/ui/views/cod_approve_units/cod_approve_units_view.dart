import 'package:examify/models/student_registered_units.dart';
import 'package:examify/ui/bottom_sheets/student_register_unit/student_register_unit_sheet.dart';
import 'package:examify/ui/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'cod_approve_units_viewmodel.dart';

class CodApproveUnitsView extends StackedView<CodApproveUnitsViewModel> {
  const CodApproveUnitsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CodApproveUnitsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
        title: const Text(
          'Approve units',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: DropdownButton<String>(
              value: viewModel.getselectedSemester,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  viewModel.setSelectedSemester(newValue);
                }
              },
              style: const TextStyle(color: Colors.white),
              dropdownColor: primaryColor,
              icon: Icon(Icons.arrow_drop_down, color: Colors.white),
              items: viewModel.semesters
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      body: StreamBuilder<List<StudentsRegisteredUnitsModel>>(
        stream: viewModel.unitsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No units to approve.'));
          }

          final units = snapshot.data!;
          final students = groupByStudent(units);

          return ListView.builder(
            itemCount: students.keys.length,
            itemBuilder: (context, index) {
              final studentUid = students.keys.elementAt(index);
              final studentUnits = students[studentUid]!;

              return Card(
                margin: const EdgeInsets.all(10.0),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        studentUnits.first.studentName ?? 'Unknown',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Registration No: ${studentUnits.first.studentRegNo ?? 'N/A'}',
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Units:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      ...studentUnits.map((unit) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(unit.unitName ?? 'Unknown Unit'),
                          )),
                      const SizedBox(height: 10),
                      (studentUnits.any((unit) => unit.isUnitApproved == false))
                          ? ElevatedButton(
                              onPressed: () async {
                                final unitCodes = studentUnits
                                    .map((unit) => unit.unitCode!)
                                    .toList();
                                await viewModel.approveUnitsForStudent(
                                    unitCodes, studentUid);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                              ),
                              child: viewModel.isBusy
                                  ? const CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    )
                                  : const Text(
                                      'Approve All Units',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                            )
                          : const Center(
                              child: Text(
                                'All units approved',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  CodApproveUnitsViewModel viewModelBuilder(BuildContext context) =>
      CodApproveUnitsViewModel();

  Map<String, List<StudentsRegisteredUnitsModel>> groupByStudent(
      List<StudentsRegisteredUnitsModel> units) {
    final Map<String, List<StudentsRegisteredUnitsModel>> studentUnits = {};
    for (final unit in units) {
      if (unit.studentUid != null) {
        if (!studentUnits.containsKey(unit.studentUid)) {
          studentUnits[unit.studentUid!] = [];
        }
        studentUnits[unit.studentUid!]!.add(unit);
      }
    }
    return studentUnits;
  }
}
