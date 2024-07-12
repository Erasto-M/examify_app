import 'package:examify/models/student_registered_units.dart';
import 'package:examify/ui/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';

import 'passlist_viewmodel.dart';

class PasslistView extends StackedView<PasslistViewModel> {
  const PasslistView({Key? key, required this.selectedSemesterStage})
      : super(key: key);
  final String selectedSemesterStage;

  @override
  Widget builder(
    BuildContext context,
    PasslistViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
          child: StreamBuilder<List<StudentsRegisteredUnitsModel>>(
            stream: viewModel.getPassLists(
                selectedSemesterStage: selectedSemesterStage),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SpinKitSpinningLines(
                    color: primaryColor,
                    size: 70,
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (!snapshot.hasData) {
                return const Center(
                  child: Text("No students found"),
                );
              } else {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width,
                    ),
                    child: DataTable(
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
                      ],
                      rows: snapshot.data!.map((student) {
                        return DataRow(cells: [
                          DataCell(
                            Text(student.studentPhoneNumber!),
                          ),
                          DataCell(
                            Text(student.studentName!),
                          ),
                        ]);
                      }).toList(),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  PasslistViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PasslistViewModel();
}
