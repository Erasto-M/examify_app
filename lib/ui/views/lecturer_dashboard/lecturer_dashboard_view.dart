import 'package:examify/models/addUnit.dart';
import 'package:examify/models/special_exams_model.dart';
import 'package:examify/models/student_registered_units.dart';
import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/common/ui_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rxdart/streams.dart';
import 'package:stacked/stacked.dart';

import 'lecturer_dashboard_viewmodel.dart';

class LecturerDashboardView extends StackedView<LecturerDashboardViewModel> {
  const LecturerDashboardView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LecturerDashboardViewModel viewModel,
    Widget? child,
  ) {
    DateTime now = DateTime.now();
    String greeting = viewModel.getGreeting(now);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          centerTitle: true,
          title: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Dedan Kimathi University ',
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
            preferredSize: const Size.fromHeight(40),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 10),
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
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpaceSmall,
                const Text(
                  "Courses you are teaching",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpaceMedium,
                SizedBox(
                  height: 400,
                  child: FutureBuilder(
                    future: viewModel.fetchLecturerUnits(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: SpinKitSpinningLines(
                            color: primaryColor,
                            size: 80,
                          ),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            AddUnitModel unit = snapshot.data![index];
                            return Card(
                              color: Colors.white,
                              child: ListTile(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(unit.unitDepartment!),

                                    Row(
                                      children: [
                                        Text(unit.unitCode),
                                        const SizedBox(width: 10),
                                        Flexible(
                                          child: Text(
                                            unit.unitName,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            maxLines:
                                                null, // Allows the text to use as many lines as needed
                                            overflow: TextOverflow
                                                .visible, // Ensures text will continue to the next line if it overflows
                                          ),
                                        ),
                                      ],
                                    ),

                                    // Add some spacing between the code and the name
                                  ],
                                ),
                                subtitle: Center(
                                  child: InkWell(
                                    onTap: () {
                                      viewModel.navigateToViewStudents(
                                        unitCode: unit.unitCode,
                                        unitName: unit.unitName,
                                      );
                                    },
                                    child: Container(
                                      height: 50,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Assign marks',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Special Exams',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpaceMedium,
                SizedBox(
                  height: 300,
                  child: StreamBuilder(
                      stream: viewModel.mySpecialExamUnits(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(snapshot.error.toString()),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text('No Specials'),
                          );
                        } else {
                          List<SpecialExamsModel> specials = snapshot.data!;
                          List<Stream<List<StudentsRegisteredUnitsModel>>>
                              studentsStream = [];
                          for (var special in specials) {
                            studentsStream
                                .add(viewModel.getStudentByIdAndUnitCode(
                              studentId: special.studeUid!,
                              unitCode: special.unitCode!,
                            ));
                          }
                          return StreamBuilder(
                              stream: CombineLatestStream.list(studentsStream),
                              builder: (context, snapshot1) {
                                if (snapshot1.hasData) {
                                  List<List<StudentsRegisteredUnitsModel>>?
                                      student = snapshot1.data;
                                  if (student!.length != specials.length) {
                                    return const Center(
                                      child: Text('Length Mismatch'),
                                    );
                                  }
                                  return ListView.builder(
                                      itemCount: specials.length,
                                      itemBuilder: (context, index) {
                                        final studentUnits1 = student[index];
                                        if (studentUnits1.isEmpty) {
                                          return const SizedBox();
                                        }
                                        final units = specials[index];

                                        return Card(
                                          color: Colors.white,
                                          child: ListTile(
                                            title: Text(
                                              units.studentName!,
                                              style: const TextStyle(
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(units.studeRegNo!),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                units.specialExamStatus ==
                                                        'Approved'
                                                    ? Row(
                                                        children: [
                                                          Text(
                                                            units.unitCode!,
                                                            style:
                                                                const TextStyle(),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Flexible(
                                                              child: Text(units
                                                                  .unitName!)),
                                                        ],
                                                      )
                                                    : units.specialExamStatus ==
                                                            'Lecturer Approved'
                                                        ? Row(
                                                            children: [
                                                              Text(
                                                                units.unitCode!,
                                                                style:
                                                                    const TextStyle(),
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Flexible(
                                                                  child: Text(units
                                                                      .unitName!)),
                                                            ],
                                                          )
                                                        : Column(
                                                            children: [
                                                              Text(
                                                                units.unitCode!,
                                                                style:
                                                                    const TextStyle(),
                                                              ),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(units
                                                                  .unitName!),
                                                            ],
                                                          ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                const Text(
                                                  "Reason for Special Exam:",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(units.specialExamReason!),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Status:",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      units.specialExamStatus!,
                                                      style: TextStyle(
                                                          color: units.specialExamStatus ==
                                                                      'Lecturer Approved' ||
                                                                  units.specialExamStatus ==
                                                                      'Approved'
                                                              ? primaryColor
                                                              : units.specialExamStatus ==
                                                                      'pending'
                                                                  ? Colors
                                                                      .orange
                                                                  : Colors.red),
                                                    ),
                                                  ],
                                                ),
                                                ...studentUnits1
                                                    .map((studentUnits1) {
                                                  return Column(
                                                    children: [
                                                      (studentUnits1
                                                                      .assignMent1Marks ==
                                                                  null ||
                                                              studentUnits1
                                                                      .assignMent2Marks ==
                                                                  null ||
                                                              studentUnits1
                                                                      .cat1Marks ==
                                                                  null ||
                                                              studentUnits1
                                                                      .cat2Marks ==
                                                                  null)
                                                          ? Row(
                                                              children: [
                                                                const Text(
                                                                  "Eligible? ",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Flexible(
                                                                  child: Text(
                                                                    (studentUnits1.assignMent1Marks == null ||
                                                                            studentUnits1.assignMent2Marks ==
                                                                                null ||
                                                                            studentUnits1.cat1Marks ==
                                                                                null ||
                                                                            studentUnits1.cat2Marks ==
                                                                                null)
                                                                        ? "No!! "
                                                                        : "Yes ",
                                                                    style: TextStyle(
                                                                        color: (studentUnits1.assignMent1Marks == null || studentUnits1.assignMent2Marks == null || studentUnits1.cat1Marks == null || studentUnits1.cat2Marks == null)
                                                                            ? Colors
                                                                                .red
                                                                            : primaryColor,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : const SizedBox(),
                                                      verticalSpaceSmall,
                                                      (studentUnits1
                                                                      .assignMent1Marks ==
                                                                  null ||
                                                              studentUnits1
                                                                      .assignMent2Marks ==
                                                                  null ||
                                                              studentUnits1
                                                                      .cat1Marks ==
                                                                  null ||
                                                              studentUnits1
                                                                      .cat2Marks ==
                                                                  null)
                                                          ? Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(10),
                                                                  color: units.specialExamStatus == 'Lecturer Approved'
                                                                      ? primaryColor
                                                                      : units.specialExamStatus == 'pending'
                                                                          ? Colors.red
                                                                          : Colors.orange),
                                                              child: units.specialExamStatus ==
                                                                      'pending'
                                                                  ? viewModel
                                                                          .isBusy
                                                                      ? const CircularProgressIndicator(
                                                                          color:
                                                                              Colors.white,
                                                                        )
                                                                      : const Text(
                                                                          'Enter cats & assignments inorder to approve',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        )
                                                                  : const Text(
                                                                      'Rejected',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                            )
                                                          : units.specialExamStatus ==
                                                                  'Lecturer Approved'
                                                              ? const SizedBox()
                                                              : units.specialExamStatus ==
                                                                      'Approved'
                                                                  ? const SizedBox()
                                                                  : InkWell(
                                                                      onTap:
                                                                          () {
                                                                        viewModel
                                                                            .approveSpecialExam(
                                                                          unitCode:
                                                                              units.unitCode,
                                                                          studentId:
                                                                              units.studeUid,
                                                                        );
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(10),
                                                                            color: units.specialExamStatus == 'Lecturer Approved'
                                                                                ? primaryColor
                                                                                : units.specialExamStatus == 'pending'
                                                                                    ? Colors.orange
                                                                                    : Colors.red),
                                                                        child: units.specialExamStatus ==
                                                                                'pending'
                                                                            ? viewModel.isBusy
                                                                                ? const CircularProgressIndicator(
                                                                                    color: Colors.white,
                                                                                  )
                                                                                : const Text(
                                                                                    'click to Approve',
                                                                                    style: TextStyle(
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  )
                                                                            : const Text(
                                                                                'Rejected',
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                ),
                                                                              ),
                                                                      ),
                                                                    ),
                                                    ],
                                                  );
                                                })
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                } else {
                                  return const Center(
                                    child: Text('Student Details Not found'),
                                  );
                                }
                              });
                        }
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  LecturerDashboardViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LecturerDashboardViewModel();
  @override
  void onViewModelReady(LecturerDashboardViewModel viewModel) {
    viewModel.getCurrentUserDetails();
    super.onViewModelReady(viewModel);
  }
}
