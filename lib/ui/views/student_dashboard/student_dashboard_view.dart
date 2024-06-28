import 'dart:io';

import 'package:examify/models/addUnit.dart';
import 'package:examify/models/student_registered_units.dart';
import 'package:examify/ui/bottom_sheets/student_register_unit/student_register_unit_sheet.dart';
import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/common/ui_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stacked/stacked.dart';

import 'student_dashboard_viewmodel.dart';

class StudentDashboardView extends StackedView<StudentDashboardViewModel> {
  const StudentDashboardView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StudentDashboardViewModel viewModel,
    Widget? child,
  ) {
    DateTime now = DateTime.now();
    String greeting = viewModel.getGreeting(now);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Container(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height / 7,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                    child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          '${greeting} , ',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        verticalSpaceTiny,
                        Text(
                          viewModel.userDetails["userName"] ?? "UserName",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        verticalSpaceSmall,
                        Text(
                          "${now.day}-${now.month}-${now.year}  ${now.hour}: ${now.minute} ${now.hour > 12 ? "PM" : "AM"}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 40,
                      backgroundImage: AssetImage('Assets/Images/man1.jpeg'),
                    ),
                  ],
                )),
              ),
              verticalSpaceSmall,
              // My Courses row
              Row(
                children: [
                  const Text(
                    "My Courses",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
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
                        value: viewModel.getSelectedSemesterStageForCourses,
                        items: viewModel.semesterStages
                            .map((String semester) => DropdownMenuItem(
                                  value: semester,
                                  child: Text(semester),
                                ))
                            .toList(),
                        onChanged: (newValue) {
                          viewModel.setSelectedSemesterStageForCourses(
                              newValue.toString());
                        },
                      ))
                ],
              ),
              verticalSpaceSmall,
              verticalSpaceSmall,
              // Courses List
              Expanded(
                flex: 2,
                child: viewModel.isBusy
                    ? const SpinKitSpinningLines(color: primaryColor)
                    : StreamBuilder<List<StudentsRegisteredUnitsModel>>(
                        stream: viewModel.fetchMyUnits(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: SpinKitSpinningLines(
                                color: primaryColor,
                                size: 40,
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return const Center(
                              child: Text("Error fetching units"),
                            );
                          } else if (!snapshot.hasData) {
                            return const Center(
                              child: Text("No Units found"),
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
                                        "Unit Code",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "Unit Name",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "Assignment 1",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "Assignment 2",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "Cat 1",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "cat 2",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "Exam ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "Total marks",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "Grade",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ],
                                  rows: snapshot.data!.map((units) {
                                    return DataRow(cells: [
                                      DataCell(Text(units.unitCode!)),
                                      DataCell(Text(units.unitName!)),
                                      DataCell(
                                        Text(
                                          units.assignMent1Marks.toString(),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          units.assignMent2Marks.toString(),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          units.cat1Marks.toString(),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          units.cat2Marks.toString(),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          units.examMarks.toString(),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          units.totalMarks.toString(),
                                        ),
                                      ),
                                      DataCell(
                                        Text(units.grade!),
                                      ),
                                    ]);
                                  }).toList(),
                                ),
                              ),
                            );
                          }
                        }),
              ),
              verticalSpaceSmall,
              Flexible(
                child: Row(
                  children: [
                    const Text(
                      "Transcripts",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
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
                          value:
                              viewModel.getSelectedSemesterStageForTranscripts,
                          items: viewModel.semesterStages
                              .map((String semester) => DropdownMenuItem(
                                    value: semester,
                                    child: Text(semester),
                                  ))
                              .toList(),
                          onChanged: (newValue) {
                            viewModel.setSelectedSemesterStageForTranscripts(
                                newValue.toString());
                          },
                        ))
                  ],
                ),
              ),
              verticalSpaceSmall,
              StreamBuilder<List<StudentsRegisteredUnitsModel>>(
                  stream: viewModel.fetchMyUnits(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SpinKitSpinningLines(
                          color: primaryColor,
                          size: 40,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text("Error fetching units"),
                      );
                    } else if (!snapshot.hasData) {
                      return const Center(
                        child: Text("No Units found"),
                      );
                    } else {
                      return InkWell(
                        onTap: () async {
                          var transcript = await viewModel.generateTrancript(
                              snapshot.data!,
                              viewModel.getSelectedSemesterStageForTranscripts);
                          final output = await getTemporaryDirectory();
                          final file = File('${output.path}/transcript.pdf');
                          await file.writeAsBytes(await transcript.save());
                          viewModel.setPdfPath(file.path);
                          viewModel.navigateToTrancscriptView();
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'Click here to view ${viewModel.getSelectedSemesterStageForTranscripts} Transcipt',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      );
                    }
                  }),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.white,
            foregroundColor: primaryColor,
            onPressed: () {
              viewModel.showRegisterUnitBottomSheet();
            },
            label: const Text(
              'Register Unit',
              style: TextStyle(color: Colors.black),
            )),
      ),
    );
  }

  @override
  StudentDashboardViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StudentDashboardViewModel();
  @override
  void onViewModelReady(StudentDashboardViewModel viewModel) {
    viewModel.getCurrentUserDetails();
  }
}
//added text
