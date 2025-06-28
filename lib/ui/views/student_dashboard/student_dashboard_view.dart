import 'dart:io';

import 'package:examify/models/addUnit.dart';
import 'package:examify/models/student_registered_units.dart';
import 'package:examify/ui/bottom_sheets/student_register_unit/student_register_unit_sheet.dart';
import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/common/ui_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: primaryColor,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        centerTitle: true,
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Dedan Kimathi University ', // Replace with your university name
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'BSC Computer Science', // Replace with your department name
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
        actions: [
          // ignore: avoid_unnecessary_containers
          Container(
            margin: const EdgeInsets.only(right: 10, top: 2),
            child: const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 30,
              backgroundImage: AssetImage('Assets/Images/man1.jpeg'),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40), // Adjust height as needed
          child: Padding(
            padding: const EdgeInsets.only(
                left: 20, bottom: 10), // Adjust padding as needed
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    '${greeting} ${viewModel.userDetails["userName"] ?? ""}, ${now.day}-${now.month}-${now.year}  ${now.hour}: ${now.minute} ${now.hour > 12 ? "PM" : "AM"}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child: Column(
            children: [
              verticalSpaceSmall,
              // My Courses row
              Row(
                children: [
                  const Text(
                    "My Courses",
                    style: TextStyle(
                      fontSize: 20,
                      color: primaryColor,
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
              SizedBox(
                child: viewModel.isBusy
                    ? const SpinKitSpinningLines(color: primaryColor)
                    : StreamBuilder<List<StudentsRegisteredUnitsModel>>(
                        stream: viewModel.getSelectedSemesterStageForCourses ==
                                'Y1'
                            ? viewModel.fetchMyUnits2()
                            : viewModel.getSelectedSemesterStageForCourses ==
                                    'Y2'
                                ? viewModel.fetchMyUnits2()
                                : viewModel.getSelectedSemesterStageForCourses ==
                                        'Y3'
                                    ? viewModel.fetchMyUnits2()
                                    : viewModel.getSelectedSemesterStageForCourses ==
                                            'Y4'
                                        ? viewModel.fetchMyUnits2()
                                        : viewModel.fetchMyUnits(),
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
                            List<StudentsRegisteredUnitsModel> snapshotData =
                                snapshot.data!;

                            double meanScore =
                                viewModel.calculateMeanScore(snapshot.data!);
                            String meanGrade =
                                viewModel.calculateMeanGrade(meanScore);
                            String recommendation =
                                snapshotData.any((unit) => unit.grade == 'E')
                                    ? 'Fail' :(viewModel.getSelectedSemesterStageForCourses == 'Y1' ||
                                                                          viewModel.getSelectedSemesterStageForCourses ==
                                                                              'Y2' ||
                                                                          viewModel.getSelectedSemesterStageForCourses ==
                                                                              'Y3' ||
                                                                          viewModel.getSelectedSemesterStageForCourses ==
                                                                              'Y4') &&
                                                                      meanScore >=
                                                                          40 ? 'Proceed to the Next year of Study'
                                    : viewModel.getRecommendation(meanGrade);

                            return snapshot.data!.isEmpty
                                ? const Center(
                                    child: Text("No Units found"),
                                  )
                                : snapshotData.any(
                                        (unit) => unit.isUnitApproved == false)
                                    ? const Center(
                                        child: Text(
                                          "Registered units waiting approval",
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      )
                                    : Column(
                                        children: [
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: ConstrainedBox(
                                              constraints: BoxConstraints(
                                                minWidth: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                              ),
                                              child: DataTable(
                                                columns: const [
                                                  DataColumn(
                                                    label: Text(
                                                      "Unit Code",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                  DataColumn(
                                                    label: Text(
                                                      "Unit Name",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                  DataColumn(
                                                    label: Text(
                                                      "Assignment 1",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                  DataColumn(
                                                    label: Text(
                                                      "Assignment 2",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                  DataColumn(
                                                    label: Text(
                                                      "Cat 1",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                  DataColumn(
                                                    label: Text(
                                                      "cat 2",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                  DataColumn(
                                                    label: Text(
                                                      "Grade",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                ],
                                                rows:
                                                    snapshot.data!.map((units) {
                                                  return DataRow(cells: [
                                                    DataCell(
                                                        Text(units.unitCode!)),
                                                    DataCell(
                                                        Text(units.unitName!)),
                                                    DataCell(
                                                      Text(
                                                        units.assignMent1Marks ==
                                                                null
                                                            ? 'NA'
                                                            : units
                                                                .assignMent1Marks
                                                                .toString(),
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Text(units.assignMent2Marks ==
                                                              null
                                                          ? 'NA'
                                                          : units
                                                              .assignMent2Marks
                                                              .toString()),
                                                    ),
                                                    DataCell(
                                                      Text(
                                                        units.cat1Marks == null
                                                            ? 'NA'
                                                            : units.cat1Marks
                                                                .toString(),
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Text(
                                                        units.cat2Marks == null
                                                            ? 'NA'
                                                            : units.cat2Marks
                                                                .toString(),
                                                      ),
                                                    ),
                                                    DataCell(
                                                      units.appliedSpecialExam ==
                                                              true
                                                          ? const Text(
                                                              'Incomplete',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                            )
                                                          : Text(
                                                              units.grade ??
                                                                  'NA',
                                                            ),
                                                    ),
                                                  ]);
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                          verticalSpaceSmall,
                                          if (!viewModel.hasSpecialExams(
                                              snapshot.data!)) ...[
                                            meanScore == 0
                                                ? const SizedBox()
                                                : snapshotData.any((unit) =>
                                                        unit.examMarks == null)
                                                    ? const SizedBox()
                                                    : Row(
                                                        children: [
                                                          Text(
                                                            'Mean Score: $meanScore ',
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          const Spacer(),
                                                          Text(
                                                            'MeanGrade: $meanGrade',
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                            verticalSpaceSmall,
                                            meanScore == 0
                                                ? const SizedBox()
                                                : snapshotData.any((unit) =>
                                                        unit.examMarks == null)
                                                    ? const SizedBox()
                                                    : Row(
                                                        children: [
                                                          const Text(
                                                            'Reccomendation: ',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          snapshotData.any(
                                                                  (unit) =>
                                                                      unit.grade ==
                                                                      'E')
                                                              ? const Text(
                                                                  'Fail')
                                                              : (viewModel.getSelectedSemesterStageForCourses == 'Y1' ||
                                                                          viewModel.getSelectedSemesterStageForCourses ==
                                                                              'Y2' ||
                                                                          viewModel.getSelectedSemesterStageForCourses ==
                                                                              'Y3' ||
                                                                          viewModel.getSelectedSemesterStageForCourses ==
                                                                              'Y4') &&
                                                                      meanScore >=
                                                                          40
                                                                  ? const Flexible(
                                                                    child: const Text(
                                                                        "Proceed to the Next year of Study"),
                                                                  )
                                                                  : Text(
                                                                      recommendation),
                                                        ],
                                                      ),
                                          ],
                                          verticalSpaceTiny,
                                          verticalSpaceSmall,
                                          const SizedBox(
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Transcripts",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: primaryColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          verticalSpaceSmall,

                                
                                         snapshotData.any((unit)=> unit.examMarks == null) ? const SizedBox() :
                                          InkWell(
                                            onTap: () async {
                                              var transcript =
                                                  viewModel.generateTranscript(
                                                students: snapshot.data!,
                                                semesterStage: viewModel
                                                    .getSelectedSemesterStageForCourses,
                                                meanGrade: meanGrade,
                                                meanScore: meanScore,
                                                recommendation: recommendation,
                                              );
                                              final output =
                                                  await getTemporaryDirectory();
                                              final file = File(
                                                  '${output.path}/transcript.pdf');
                                              await file.writeAsBytes(
                                                  await transcript.save());
                                              viewModel.setPdfPath(file.path);
                                              viewModel
                                                  .navigateToTrancscriptView();
                                            },
                                            child: Container(
                                              height: 50,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Click here to view ${viewModel.getSelectedSemesterStageForCourses} Transcipt',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                          }
                        }),
              ),

              verticalSpaceSmall,
              verticalSpaceSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton.extended(
                      heroTag: 'register_unit',
                      backgroundColor: Colors.grey[100],
                      foregroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      elevation: 0,
                      onPressed: () {
                        viewModel.showRegisterUnitBottomSheet();
                      },
                      label: const Text(
                        'Register Unit',
                        style: TextStyle(color: Colors.black),
                      )),
                  horizontalSpaceMedium,
                  FloatingActionButton.extended(
                      heroTag: 'apply_special_exam',
                      backgroundColor: Colors.grey[100],
                      foregroundColor: primaryColor,
                       shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      elevation: 0,
                      onPressed: () {
                        viewModel.navigateToApplySpecialExam(
                            semesterStage:
                                viewModel.getSelectedSemesterStageForCourses);
                      },
                      label: const Text(
                        'Special Exams',
                        style: TextStyle(color: Colors.black),
                      )),
                ],
              ),
              verticalSpaceMedium,
            ],
          ),
        ),
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
