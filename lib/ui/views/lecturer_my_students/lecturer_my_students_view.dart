import 'package:examify/models/student_registered_units.dart';
import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
        backgroundColor: Colors.grey[200],
        body: Container(
          padding: const EdgeInsets.only(left: 10.0, right: 5.0, top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  Text(
                    unitName,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              verticalSpaceSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //search students
                  Expanded(
                    child: Container(
                      height: 50,
                      margin: const EdgeInsets.only(right: 10),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search students",
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: const Icon(Icons.mic),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
                          "EnterMarks",
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
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ]),
                            child: DropdownButton(
                              value: viewModel.selectedExamModuleToEnterMarks,
                              items: viewModel.examModelues
                                  .map((String examModule) => DropdownMenuItem(
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
                    Center(
                      child: InkWell(
                        onTap: () {
                          viewModel.openEditStudentMarksSheet(
                            unitCode: unitCode,
                            unitName: unitName,
                          );
                        },
                        child: Container(
                          height: 40,
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(10)),
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
                    )
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
              //list of all students

              Expanded(
                child: StreamBuilder<List<StudentsRegisteredUnitsModel>>(
                  stream: viewModel.getAllMyStudents(unitCode: unitCode),
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
                                  "Name",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                              ),
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
    );
  }

  @override
  LecturerMyStudentsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LecturerMyStudentsViewModel();
}

//erasto flutter developer