import 'package:examify/models/addUnit.dart';
import 'package:examify/models/student_registered_units.dart';
import 'package:examify/ui/bottom_sheets/student_register_unit/student_register_unit_sheet.dart';
import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/common/ui_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
                            fontSize: 18,
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
                        value: viewModel.getSelectedSemesterStage,
                        items: viewModel.semesterStages
                            .map((String semester) => DropdownMenuItem(
                                  value: semester,
                                  child: Text(semester),
                                ))
                            .toList(),
                        onChanged: (newValue) {
                          viewModel
                              .setSelectedSemesterStage(newValue.toString());
                        },
                      ))
                ],
              ),
              verticalSpaceSmall,
              // Courses List
              Expanded(
                flex: 3,
                child: viewModel.isBusy
                    ? const SpinKitSpinningLines(color: primaryColor)
                    : StreamBuilder(
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
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  StudentsRegisteredUnitsModel unit =
                                      snapshot.data![index];
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    padding: const EdgeInsets.all(10),
                                    height: MediaQuery.of(context).size.height /
                                        6.8,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                                "${unit.unitCode} - ${unit.unitName}"),
                                            const Spacer(),
                                            IconButton(
                                                onPressed: () {},
                                                icon: const Icon(Icons
                                                    .arrow_circle_up_outlined)),
                                          ],
                                        ),
                                        verticalSpaceTiny,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                              decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: const Column(
                                                children: [
                                                  Icon(
                                                    Icons.remove,
                                                    size: 10,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                    "Drop Course",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            horizontalSpaceMedium,
                                            horizontalSpaceMedium,
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                              decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: const Row(
                                                children: [
                                                  Text(
                                                    "Apply Special ",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                });
                          }
                        }),
              ),
              verticalSpaceSmall,
              Flexible(
                flex: 1,
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
                          horizontal: 10, vertical: 5),
                      height: 30,
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
                      child: const Row(
                        children: [
                          Text(
                            "Y1S1",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: primaryColor,
            foregroundColor: primaryColor,
            onPressed: () {
              viewModel.showRegisterUnitBottomSheet();
            },
            label: const Text(
              'Register Unit',
              style: TextStyle(color: Colors.white),
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
