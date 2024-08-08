import 'dart:io';

import 'package:examify/models/addUnit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stacked/stacked.dart';
import '../../../models/student_registered_units.dart';
import '../../../models/usersModel.dart';
import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import 'admin_student_performance_viewmodel.dart';

class AdminStudentPerformanceView
    extends StackedView<AdminStudentPerformanceViewModel> {
  const AdminStudentPerformanceView({Key? key, required this.yearName})
      : super(key: key);
  final String yearName;
  @override
  Widget builder(
    BuildContext context,
    AdminStudentPerformanceViewModel viewModel,
    Widget? child,
  ) {
    List<AppUser> users = viewModel.users;
    String currentYearName = yearName.endsWith("one")
        ? "Y1"
        : yearName.endsWith("two")
            ? "Y2"
            : yearName.endsWith("three")
                ? "Y3"
                : "Y4";

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: primaryColor,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      "Students Performance Sheets",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(width: 50),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "$yearName Students",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                // tabrow to click s1 or s2
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        viewModel.setSelectedSem('${currentYearName}S1');
                      },
                      child: Text("${currentYearName}S1"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        viewModel.setSelectedSem('${currentYearName}S2');
                      },
                      child: Text("${currentYearName}S2"),
                    ),
                    Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ]),
                        child: DropdownButton(
                          value: viewModel.getSelectedCohort.isNotEmpty
                              ? viewModel.getSelectedCohort
                              : null,
                          hint: const Text("Select Cohort"),
                          items: viewModel.cohorts
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            viewModel.setSelectedCohort(newValue.toString());
                          },
                        )),
                  ],
                ),
                verticalSpaceSmall,
                SizedBox(
                  height: 60,
                  child: StreamBuilder<List<Map<String, dynamic>>>(
                    stream: viewModel
                        .getConsolidatedMarksheets(viewModel.getSelectedSem),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: SpinKitSpinningLines(
                            color: primaryColor,
                            size: 70,
                          ),
                        );
                      } else if (!snapshot.hasData) {
                        return const Center(
                          child: Text("No data found"),
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text("An error occurred"),
                        );
                      } else {
                        final students = snapshot.data!;
                        return InkWell(
                          onTap: () async {
                            var transcript =
                                viewModel.generateConsolidatedNMarkSheet(
                              students: students,
                              semesterStage: viewModel.getSelectedSem,
                            );
                            final output = await getTemporaryDirectory();
                            final file = File('${output.path}/transcript.pdf');
                            await file.writeAsBytes(await transcript.save());
                            viewModel.setPdfPath(file.path);
                            viewModel.navigateToConsolidatedMarksView();
                          },
                          child: Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'Generate Consolidated Mark Sheet for ${viewModel.getSelectedSem}',
                                style: const TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),

                verticalSpaceSmall,
                 Container(
                          margin: const EdgeInsets.only(right: 5),
                          padding: const EdgeInsets.symmetric(horizontal: 5),
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
                                          .selectedUnitCode.isNotEmpty
                                      ? viewModel.selectedUnitCode
                                      : null,
                                  hint: Flexible(
                                      child: const Text("Please select unit")),
                                  items: viewModel.unitsPerSelectedSemester
                                          ?.map((unit) {
                                        return DropdownMenuItem<String>(
                                          value: unit.unitCode,
                                          child: Flexible(
                                            child: Text(
                                              unit.unitName,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        );
                                      }).toList() ??
                                      [],
                                  onChanged: (newValue) {
                                    if (newValue != null) {
                                      viewModel
                                          .setSelectedUnitCode(newValue);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                verticalSpaceSmall,
                SizedBox(
                  child: StreamBuilder<List<StudentsRegisteredUnitsModel>>(
                    stream: viewModel.fetchStudentsAccordingToYearStream(
                        yearName: yearName,
                        semesterStage: viewModel.getSelectedSem),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: SpinKitSpinningLines(
                            color: primaryColor,
                            size: 70,
                          ),
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
                                    "cat 2",
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    "Exam ",
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
                                  DataCell(
                                    Text(student.studentRegNo!),
                                  ),
                                  DataCell(
                                    Text(student.studentName!),
                                  ),
                                  DataCell(
                                    Text(
                                      student.assignMent1Marks.toString(),
                                    ),
                                  ),
                                  DataCell(
                                    Text(student.assignMent2Marks.toString()),
                                  ),
                                  DataCell(
                                    Text(student.cat1Marks.toString()),
                                  ),
                                  DataCell(
                                    Text(
                                      student.cat2Marks.toString(),
                                    ),
                                  ),
                                  DataCell(
                                    Text(student.examMarks.toString()),
                                  ),
                                  DataCell(
                                    Text(student.totalMarks.toString()),
                                  ),
                                  DataCell(
                                    Text(student.grade.toString()),
                                  ),
                                ]);
                              }).toList(),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  AdminStudentPerformanceViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AdminStudentPerformanceViewModel();

  @override
  void onViewModelReady(AdminStudentPerformanceViewModel viewModel) {
    viewModel.setInitSemValue(yearName);
    viewModel.fetchUnits();
    super.onViewModelReady(viewModel);
  }
}
