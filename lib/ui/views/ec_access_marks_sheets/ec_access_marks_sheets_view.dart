import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examify/models/student_registered_units.dart';
import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';

import '../../../models/addUnit.dart';
import 'ec_access_marks_sheets_viewmodel.dart';

class EcAccessMarksSheetsView
    extends StackedView<EcAccessMarksSheetsViewModel> {
  const EcAccessMarksSheetsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    EcAccessMarksSheetsViewModel viewModel,
    Widget? child,
  ) {
    return DefaultTabController(
      length: viewModel.years.length,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Access Marks Sheets'),
            bottom: TabBar(
              isScrollable: true,
              tabs: viewModel.years.map((year) {
                return Tab(text: year);
              }).toList(),
              onTap: (index) {
                viewModel.setSelectedSemester(semester: viewModel.years[index]);
              },
            ),
          ),
          backgroundColor: Colors.grey[200],
          body: SingleChildScrollView(
            child: FutureBuilder<DocumentSnapshot?>(
              future: viewModel.getReportsAvailabilityStatus(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitSpinningLines(
                      color: primaryColor,
                      size: 70,
                    ),
                  );
                } else if (snapshot.hasError || !snapshot.hasData) {
                  return const Center(
                    child: Text("Error or no data found"),
                  );
                } else {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  bool isAvailable =
                      data['${viewModel.selectedSemester}_available'] ?? false;
            
                  return Container(
                    padding:
                        const EdgeInsets.only(left: 10.0, right: 5.0, top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: isAvailable,
                              onChanged: (bool? value) {
                                if (value != null) {
                                  viewModel.updateReportsAvailabilityStatus(
                                      value, viewModel.selectedSemester);
                                }
                              },
                            ),
                            Text(
                              'Make ${viewModel.selectedSemester} reports available',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        verticalSpaceSmall,
                      
                            
                                  Container(
                                    margin: const EdgeInsets.only(right: 5),
                                    padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(3),
                                      
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            value: viewModel
                                                    .selectedUnitToGetMarks.isNotEmpty
                                                ? viewModel.selectedUnitToGetMarks
                                                : null,
                                            hint: Flexible(child: const Text("Please select unit")),
                                            items: viewModel.unitsPerSelectedSemester
                                                    ?.map((unit) {
                                                  return DropdownMenuItem<String>(
                                                    value: unit.unitCode,
                                                    child: Flexible(child: Text(unit.unitName, overflow: TextOverflow.ellipsis,),),
                                                  );
                                                }).toList() ??
                                                [],
                                            onChanged: (newValue) {
                                              if (newValue != null) {
                                                viewModel.setSelectedUnitToGetMarks(
                                                    newValue);
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            
                        verticalSpaceSmall,
                        const Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                        const Text(
                          "Marks Sheet ",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                          ),
                        ),
                        verticalSpaceSmall,
                        SizedBox(
                          child:
                              StreamBuilder<List<StudentsRegisteredUnitsModel>>(
                            stream: viewModel.getAllMyStudents(
                                unitCode: viewModel.selectedUnitToGetMarks),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: SpinKitSpinningLines(
                                    color: primaryColor,
                                    size: 70,
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return const Center(
                                  child: Text("Error or no data found"),
                                );
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return const Center(
                                  child: Text("No data found"),
                                );
                              } else if (snapshot.hasData) {
                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minWidth: MediaQuery.of(context).size.width,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        DataTable(
                                          columns: const [
                                            DataColumn(
                                              label: Text(
                                                "RegNo",
                                                style: TextStyle(
                                                    color: primaryColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                "Name",
                                                style: TextStyle(
                                                    color: primaryColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                "Assignment 1",
                                                style: TextStyle(
                                                    color: primaryColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                "Assignment 2",
                                                style: TextStyle(
                                                    color: primaryColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                "Cat 1",
                                                style: TextStyle(
                                                    color: primaryColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                "Cat 2",
                                                style: TextStyle(
                                                    color: primaryColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                "Exam",
                                                style: TextStyle(
                                                    color: primaryColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                "Total marks",
                                                style: TextStyle(
                                                    color: primaryColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                "Grade",
                                                style: TextStyle(
                                                    color: primaryColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18),
                                              ),
                                            ),
                                          ],
                                          rows: snapshot.data!.map((student) {
                                            return DataRow(cells: [
                                              DataCell(Text(
                                                  student.studentRegNo ?? '')),
                                              DataCell(Text(
                                                  student.studentName ??
                                                      '')),
                                              DataCell(Text(student
                                                      .assignMent1Marks
                                                      ?.toString() ??
                                                  '')),
                                              DataCell(Text(student
                                                      .assignMent2Marks
                                                      ?.toString() ??
                                                  '')),
                                              DataCell(Text(
                                                  student.cat1Marks?.toString() ??
                                                      '')),
                                              DataCell(Text(
                                                  student.cat2Marks?.toString() ??
                                                      '')),
                                              DataCell(Text(
                                                  student.examMarks?.toString() ??
                                                      '')),
                                              DataCell(Text(student.totalMarks
                                                      ?.toString() ??
                                                  '')),
                                              DataCell(Text(
                                                  student.grade?.toString() ??
                                                      '')),
                                            ]);
                                          }).toList(),
                                        ),
                                        verticalSpaceMedium,
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return const Center(
                                  child: Text("No data found"),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  EcAccessMarksSheetsViewModel viewModelBuilder(BuildContext context) =>
      EcAccessMarksSheetsViewModel();

  @override
  void onViewModelReady(EcAccessMarksSheetsViewModel viewModel) {
    viewModel.setSelectedSemester(semester: viewModel.years[0]);
    viewModel.fetchUnits();
    super.onViewModelReady(viewModel);
  }
}
