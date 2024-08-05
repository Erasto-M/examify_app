import 'dart:io';

import 'package:examify/models/student_registered_units.dart';
import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stacked/stacked.dart';

import 'lecturer_my_students_viewmodel.dart';

class LecturerMyStudentsView extends StackedView<LecturerMyStudentsViewModel> {
  const LecturerMyStudentsView({
    Key? key,
    required this.unitCode,
    required this.unitName,
  });
  final String unitCode;
  final String unitName;

  @override
  Widget builder(
    BuildContext context,
    LecturerMyStudentsViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 10.0, right: 5.0, top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          viewModel.backToHome();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: primaryColor,
                        )),
                    Flexible(
                      child: Text(
                        unitName,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                verticalSpaceSmall,

                //Customize unit assessment
                StreamBuilder(
                    stream: viewModel.getAllMyStudents(unitCode: unitCode),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<StudentsRegisteredUnitsModel> student =
                            snapshot.data!;
                        return InkWell(
                          onTap: () {
                            if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "No students found for $unitName");
                            }
                            viewModel.openCustomizeAssessMentBottomSheet(
                                unitCode: unitCode,
                                unitName: unitName,
                                units: StudentsRegisteredUnitsModel(
                                  assignMent1OutOff:
                                      student[0].assignMent1OutOff,
                                  assignMent2OutOff:
                                      student[0].assignMent2OutOff,
                                  cat1Marks1OutOff: student[0].cat1Marks1OutOff,
                                  cat2MarksOutOff: student[0].cat2MarksOutOff,
                                  examMarksOutOff: student[0].examMarksOutOff,
                                ));
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.sizeOf(context).width,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[200]!,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                )
                              ],
                            ),
                            child: const Center(
                              child: Row(
                                children: [
                                  Text(
                                    'Customize assessment',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(Icons.dashboard_customize,
                                      color: primaryColor),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      return const SizedBox();
                    }),
                verticalSpaceSmall,
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Select",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.white,
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ]),
                              child: DropdownButton(
                                value: viewModel.selectedExamModuleToEnterMarks,
                                items: viewModel.examModelues
                                    .map(
                                        (String examModule) => DropdownMenuItem(
                                              value: examModule,
                                              child: Text(examModule),
                                            ))
                                    .toList(),
                                onChanged: (newValue) {
                                  viewModel.setSelectedExamModuleToEnterMarks(
                                      newValue.toString());
                                },
                              ))
                        ],
                      ),
                      verticalSpaceSmall,
                      StreamBuilder(
                          stream:
                              viewModel.getAllMyStudents(unitCode: unitCode),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<StudentsRegisteredUnitsModel> student =
                                  snapshot.data!;
                              return Center(
                                child: InkWell(
                                  onTap: () {
                                    if (snapshot.data!.isEmpty ||
                                        !snapshot.hasData) {
                                      Fluttertoast.showToast(
                                          msg:
                                              "No students found for $unitName");
                                    }
                                    viewModel.openEditStudentMarksSheet(
                                        unitCode: unitCode,
                                        unitName: unitName,
                                        student: snapshot.data!);
                                  },
                                  child: Container(
                                    height: 40,
                                    width: MediaQuery.sizeOf(context).width,
                                    decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Center(
                                      child: Text(
                                        "Click here to enter marks",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                            return const SizedBox();
                          }),
                      verticalSpaceSmall,
                      StreamBuilder(
                          stream: viewModel.getAllMyStudentsWithSpeialExams(
                              unitCode: unitCode),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<StudentsRegisteredUnitsModel> student =
                                  snapshot.data!;
                              return Center(
                                child: InkWell(
                                  onTap: () {
                                    if (!snapshot.hasData ||
                                        snapshot.data!.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg:
                                              "No students with Special exams for $unitName");
                                    }
                                    viewModel.openBottomSheetForSpecialExams(
                                        unitCode: unitCode,
                                        unitName: unitName,
                                        student: snapshot.data!);
                                  },
                                  child: Container(
                                    height: 40,
                                    width: MediaQuery.sizeOf(context).width,
                                    decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Center(
                                      child: Text(
                                        "Enter Special Exam Marks",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                            return const SizedBox();
                          }),
                      verticalSpaceSmall,
                      StreamBuilder(
                          stream: viewModel.getLecturerStudentsWithSupp(
                              unitCode: unitCode),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<StudentsRegisteredUnitsModel> student =
                                  snapshot.data!;
                              return Center(
                                child: InkWell(
                                  onTap: () {
                                    viewModel.openEditStudentMarksSheetForSupp(
                                        unitCode: unitCode,
                                        unitName: unitName,
                                        student: snapshot.data!);
                                  },
                                  child: Container(
                                    height: 40,
                                    width: MediaQuery.sizeOf(context).width,
                                    decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Center(
                                      child: Text(
                                        "Enter Supplementary Exam Marks",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }else{
                            return const Text("No supp list");
                            }
                          })
                    ],
                  ),
                ),
                verticalSpaceSmall,
                const Divider(
                  thickness: 0.5,
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
                //list of all students

                SizedBox(
                  child: StreamBuilder<List<StudentsRegisteredUnitsModel>>(
                    stream: viewModel.getAllMyStudentsWithSpecialExamOrWithout(
                        unitCode: unitCode),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: SpinKitSpinningLines(
                            color: primaryColor,
                            size: 70,
                          ),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text("No students found"),
                        );
                      } else {
                        snapshot.data!.forEach((student) async {
                          final totalMarks = ((student.assignMent1Marks! /
                                      student.assignMent1OutOff!) *
                                  5) +
                              ((student.assignMent2Marks! /
                                      student.assignMent2OutOff!) *
                                  5) +
                              ((student.cat1Marks! /
                                      student.cat1Marks1OutOff!) *
                                  10) +
                              ((student.cat2Marks! / student.cat2MarksOutOff!) *
                                  10) +
                              ((student.examMarks! / student.examMarksOutOff!) *
                                  70);
                          final grade = viewModel
                              .calculateGrade(totalMarks: totalMarks)
                              .toString();
                          await viewModel.updateTotalMarksAndGrade(
                              unit: StudentsRegisteredUnitsModel(
                            unitCode: student.unitCode,
                            studentUid: student.studentUid,
                            totalMarks: totalMarks.toInt(),
                            grade: grade,
                          ));
                        });
                        List<StudentsRegisteredUnitsModel> studentInfo =
                            snapshot.data!;
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: MediaQuery.of(context).size.width,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DataTable(
                                  columns: [
                                    const DataColumn(
                                      label: Text(
                                        "Name",
                                        style: TextStyle(
                                            color: primaryColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                    ),
                                    const DataColumn(
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
                                        "Assignment1 /${studentInfo[0].assignMent1OutOff}",
                                        style: const TextStyle(
                                            color: primaryColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "Assignment2 /${studentInfo[0].assignMent2OutOff}",
                                        style: const TextStyle(
                                            color: primaryColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "Cat1 /${studentInfo[0].cat1Marks1OutOff}",
                                        style: const TextStyle(
                                            color: primaryColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "cat2 /${studentInfo[0].cat2MarksOutOff}",
                                        style: const TextStyle(
                                            color: primaryColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "Exam /${studentInfo[0].examMarksOutOff}",
                                        style: const TextStyle(
                                            color: primaryColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                    ),
                                    const DataColumn(
                                      label: Text(
                                        "Total marks",
                                        style: TextStyle(
                                            color: primaryColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                    ),
                                    const DataColumn(
                                      label: Text(
                                        "Grade",
                                        style: TextStyle(
                                            color: primaryColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                    ),
                                    const DataColumn(
                                      label: Text(
                                        "Action",
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
                                        Text(student.studentName!),
                                      ),
                                      DataCell(
                                        Text(student.studentPhoneNumber!),
                                      ),
                                      DataCell(
                                        Text(
                                          student.assignMent1Marks.toString(),
                                        ),
                                      ),
                                      DataCell(
                                        Text(student.assignMent2Marks
                                            .toString()),
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
                                        Text(
                                          student.appliedSpecialExam == true
                                              ? "Special Exam"
                                              : student.examMarks.toString(),
                                          style: TextStyle(
                                              color:
                                                  student.appliedSpecialExam ==
                                                          true
                                                      ? Colors.red
                                                      : Colors.black),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          student.appliedSpecialExam == true
                                              ? 'Incomplete'
                                              : student.totalMarks.toString(),
                                          style: TextStyle(
                                              color:
                                                  student.appliedSpecialExam ==
                                                          true
                                                      ? Colors.red
                                                      : Colors.black),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          student.appliedSpecialExam == true
                                              ? 'inComplete'
                                              : student.grade.toString(),
                                          style: TextStyle(
                                              color:
                                                  student.appliedSpecialExam ==
                                                          true
                                                      ? Colors.red
                                                      : Colors.black),
                                        ),
                                      ),
                                      DataCell(
                                        MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: Tooltip(
                                            message:
                                                "Edit marks for ${student.studentName}",
                                            child: IconButton(
                                              onPressed: () {
                                                // Add your edit functionality here
                                                viewModel
                                                    .showEditMarksPerStudentSheet(
                                                  studentName:
                                                      student.studentName!,
                                                  studentUid:
                                                      student.studentUid!,
                                                  assignMent1Marks:
                                                      student.assignMent1Marks,
                                                  assignMent2Marks:
                                                      student.assignMent2Marks,
                                                  cat1Marks: student.cat1Marks,
                                                  cat2Marks: student.cat2Marks,
                                                  examMarks: student.examMarks,
                                                  unitCode: student.unitCode!,
                                                  assignMent1OutOff:
                                                      student.assignMent1OutOff,
                                                  assignMent2OutOff:
                                                      student.assignMent2OutOff,
                                                  cat1MarksOutOff:
                                                      student.cat1Marks1OutOff,
                                                  cat2MarksOutOff:
                                                      student.cat2MarksOutOff,
                                                  examMarksOutOff:
                                                      student.examMarksOutOff,
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.edit,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]);
                                  }).toList(),
                                ),
                                // download pdf
                                verticalSpaceMedium,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: InkWell(
                                        onTap: () async {
                                          var pdf = await viewModel.generatePDF(
                                              snapshot.data!, unitName);
                                          final output =
                                              await getTemporaryDirectory();
                                          final file =
                                              File('${output.path}/marks.pdf');
                                          await file
                                              .writeAsBytes(await pdf.save());
                                          viewModel.setPdfPath(file.path);
                                          viewModel.navigateToPdfView(
                                            unitName: unitName,
                                          );
                                        },
                                        child: Container(
                                          height: 40,
                                          width:
                                              MediaQuery.sizeOf(context).width /
                                                  2,
                                          decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: const Center(
                                            child: Text(
                                              "View Marks PDF",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    horizontalSpaceMedium,
                                  ],
                                ),
                                verticalSpaceMedium,
                              ],
                            ),
                          ),
                        );
                        //
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  LecturerMyStudentsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LecturerMyStudentsViewModel();
}
