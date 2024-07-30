import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';

import '../../../models/special_exams_model.dart';
import '../../../models/student_registered_units.dart';
import '../../common/app_colors.dart';
import '../missing_marks/missing_marks_view.dart';
import '../passlist/passlist_view.dart';
import '../special_exams_list/special_exams_list_view.dart';
import '../supplist/supplist_view.dart';
import 'student_academics_viewmodel.dart';

class StudentAcademicsView extends StackedView<StudentAcademicsViewModel> {
  const StudentAcademicsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StudentAcademicsViewModel viewModel,
    Widget? child,
  ) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: primaryColor,
          title: const Text(
            'My Academic Reports',
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
                icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
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
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            labelStyle: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            unselectedLabelStyle:
                const TextStyle(color: Colors.white, fontSize: 15),
            isScrollable: true,
            tabs: viewModel.academicLists.map((list) {
              return Tab(
                text: list,
              );
            }).toList(),
            onTap: (index) {
              viewModel.setSelectedAcademicList(viewModel.academicLists[index]);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder<DocumentSnapshot?>(
            stream: viewModel
                .getReportsAvailabilityStatus(viewModel.getselectedSemester),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return const Text('Error fetching data');
              }
              bool isAvailable = snapshot
                      .data?['${viewModel.getselectedSemester}_available'] ??
                  false;
              if (!isAvailable) {
                return const Text('Reports not yet available');
              }
              return viewModel.getSelectedAcademicList == 'Passlist'
                  ? Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: StreamBuilder<List<StudentsRegisteredUnitsModel>>(
                        stream: viewModel.getPassLists(
                            selectedSemesterStage:
                                viewModel.getselectedSemester),
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
                            return Center(
                              child: Text(snapshot.error.toString()),
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.all_inbox_sharp,
                                  color: primaryColor,
                                  size: 50,
                                ),
                                Center(
                                  child: Text('😢 We are Sorry you have not Passed',
                                      style:  TextStyle(
                                          color: Colors.black, fontSize: 16)),
                                ),
                              ],
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
                    )
                  : viewModel.getSelectedAcademicList == 'SuppList'
                      ? StreamBuilder<
                          Map<String, List<StudentsRegisteredUnitsModel>>>(
                          stream: viewModel.getSuppList(
                              semesterStage: viewModel.getselectedSemester),
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
                              return Center(
                                child: Text(snapshot.error.toString()),
                              );
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.all_inbox_sharp,
                                      color: primaryColor,
                                      size: 50,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "🎉 Congratulations! You don't have any Supplementary exams.",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              final studentsMap = snapshot.data!;
                              return SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: studentsMap.length,
                                    itemBuilder: (context, index) {
                                      final studentUid =
                                          studentsMap.keys.elementAt(index);
                                      final studentUnits =
                                          studentsMap[studentUid]!;
                                      final student = studentUnits.first;
                                      return Card(
                                        color: Colors.white,
                                        child: ListTile(
                                          title: Text(student.studentName!,
                                              style: const TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(student.studentRegNo!),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              const Center(
                                                  child: Text(
                                                'Supplementary Units:',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              )),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              ...studentUnits
                                                  .asMap()
                                                  .entries
                                                  .map((unit) => Text(
                                                      '${unit.key + 1}. ${unit.value.unitCode}: ${unit.value.unitName}'))
                                                  .toList(),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              );
                            }
                          },
                        )
                      : viewModel.getSelectedAcademicList == 'SpecialExams'
                          ? StreamBuilder<Map<String, List<SpecialExamsModel>>>(
                              stream: viewModel.getSpecialsExam(
                                  semesterStage: viewModel.getselectedSemester),
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
                                  return Center(
                                    child: Text(snapshot.error.toString()),
                                  );
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return const Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.all_inbox_sharp,
                                          color: primaryColor,
                                          size: 50,
                                        ),
                                        Text(
                                          "😊  You have not Applied for any Special Exams",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  final studentsMap = snapshot.data!;
                                  return SizedBox(
                                    height: MediaQuery.of(context).size.height,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: studentsMap.length,
                                        itemBuilder: (context, index) {
                                          final studentUid =
                                              studentsMap.keys.elementAt(index);
                                          final studentUnits =
                                              studentsMap[studentUid]!;
                                          final student = studentUnits.first;
                                          return Card(
                                            color: Colors.white,
                                            child: ListTile(
                                              title: Text(
                                                  student.studentName ?? '',
                                                  style: const TextStyle(
                                                      color: primaryColor,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              subtitle: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(student.studeRegNo ??
                                                      'Co26-01-1029/2021'),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  const Center(
                                                      child: Text(
                                                    'Special Exam Units ',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  )),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  ...studentUnits
                                                      .asMap()
                                                      .entries
                                                      .map((unit) => Text(
                                                          '${unit.key + 1}. ${unit.value.unitCode}: ${unit.value.unitName}'))
                                                      .toList(),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  );
                                }
                              },
                            )
                          : Container(
                              color: Colors.white,
                              child: StreamBuilder<
                                  Map<String,
                                      List<StudentsRegisteredUnitsModel>>>(
                                stream: viewModel.getMissingMarksList(
                                    semesterStage:
                                        viewModel.getselectedSemester),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Center(
                                      child: Text(snapshot.error.toString()),
                                    );
                                  } else if (!snapshot.hasData ||
                                      snapshot.data!.isEmpty) {
                                    return const Center(
                                      child:
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.all_inbox_sharp,
                                                color: primaryColor,
                                                size: 50,
                                              ),
                                               SizedBox(
                                                height: 20,
                                              ),
                                              Text("🎉 Congratulations!. You don't have any missing marks"),
                                            ],
                                          ),
                                    );
                                  } else {
                                    final Map<String,
                                            List<StudentsRegisteredUnitsModel>>
                                        studentsMap = snapshot.data!;
                                    return SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: studentsMap.length,
                                        itemBuilder: (context, index) {
                                          final studentUid =
                                              studentsMap.keys.elementAt(index);
                                          final studentUnits =
                                              studentsMap[studentUid]!;
                                          final student = studentUnits.first;
                                          return Card(
                                            color: Colors.white,
                                            child: ListTile(
                                              title: Text(
                                                student.studentName ?? '',
                                                style: const TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              subtitle: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(student.studentRegNo ??
                                                      'Registration No. not provided'),
                                                  const SizedBox(height: 10),
                                                  const Text(
                                                    'Missing Marks Details:',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  ...studentUnits.map((unit) {
                                                    return Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Unit: ${unit.unitName} (${unit.unitCode})',
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        if (unit.assignMent1Marks ==
                                                                null ||
                                                            unit.assignMent2Marks ==
                                                                null)
                                                          Text(
                                                              'Missing Assignments: ${unit.assignMent1Marks == null ? "Assignment 1, " : ""}${unit.assignMent2Marks == null ? "Assignment 2" : ""}'),
                                                        if (unit.cat1Marks ==
                                                                null ||
                                                            unit.cat2Marks ==
                                                                null)
                                                          Text(
                                                              'Missing CATs: ${unit.cat1Marks == null ? "CAT 1, " : ""}${unit.cat2Marks == null ? "CAT 2" : ""}'),
                                                        if (unit.examMarks ==
                                                                null ||
                                                            unit.totalMarks ==
                                                                null)
                                                          Text(
                                                              'Missing Exams: ${unit.examMarks == null ? "Exam Marks " : ""}'),
                                                      ],
                                                    );
                                                  }).toList(),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }
                                },
                              ),
                            );
            },
          ),
        ),
      ),
    );
  }

  @override
  StudentAcademicsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StudentAcademicsViewModel();
}
