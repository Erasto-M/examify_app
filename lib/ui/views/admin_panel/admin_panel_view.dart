import 'dart:io';
import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stacked/stacked.dart';
import '../../widgets/common/manage_courses/manage_courses.dart';
import '../../widgets/common/transcripts/transcripts.dart';
import '../../widgets/common/users/users.dart';
import 'admin_panel_viewmodel.dart';

class AdminPanelView extends StackedView<AdminPanelViewModel> {
  const AdminPanelView({super.key});

  @override
  Widget builder(
    BuildContext context,
    AdminPanelViewModel viewModel,
    Widget? child,
  ) {
    DateTime now = DateTime.now();
    String greeting = viewModel.getGreeting(now);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: primaryColor,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ));
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          centerTitle: true,
          title: Row(
            children: [
              Text(
                greeting,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Flexible(
                child: Text(
                  viewModel.userDetails["userName"] ?? "COD",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          actions: [
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
              preferredSize: const Size.fromHeight(0),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Text(
                      "${now.day}-${now.month}-${now.year}  ${now.hour}: ${now.minute} ${now.hour > 12 ? "PM" : "AM"}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              )),
          backgroundColor: primaryColor,
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpaceSmall,
                const Text(
                  'Manage Units',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpaceSmall,
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ManageCourses(yearName: 'Y1'),
                    ManageCourses(yearName: 'Y2'),
                    ManageCourses(yearName: 'Y3'),
                    ManageCourses(yearName: 'Y4'),
                  ],
                ),
                verticalSpaceSmall,
                verticalSpaceSmall,
                InkWell(
                  onTap: () {
                    viewModel.navigateToApproveStudentUnits();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(color: primaryColor, width: 0.1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Text('Approve Student Units',
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                verticalSpaceTiny,
                const Text(
                  'Users',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpaceTiny,
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            viewModel.navigateToRegisterNewUser();
                          },
                          child: Container(
                              height: 60,
                              width: MediaQuery.of(context).size.height / 5,
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black12, width: 1),
                                color: primaryColor,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.white,
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: Offset(0, 2),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  "Register New",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )),
                        ),
                        horizontalSpaceTiny,
                        GestureDetector(
                            onTap: () {
                              viewModel.navigateToStudents(user: "Students");
                            },
                            child: const Users(user: 'Students')),
                        horizontalSpaceTiny,
                        GestureDetector(
                            onTap: () {
                              viewModel.navigateToLecturers();
                            },
                            child: const Users(user: 'Lecturers')),
                      ],
                    ),
                  ),
                ),
                verticalSpaceSmall,
                const Text(
                  'Student Performance',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpaceTiny,
                Column(
                  children: [
                    const Transcripts(yearName: 'Year one'),
                    verticalSpaceTiny,
                    const Transcripts(yearName: 'Year two'),
                    verticalSpaceTiny,
                    const Transcripts(yearName: 'Year three'),
                    verticalSpaceTiny,
                    const Transcripts(yearName: 'Year four'),
                    verticalSpaceTiny,
                    Row(children: [
                      const Text(
                        "Select Cohort: ",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
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
                            value: viewModel.selectedCohort,
                            items: viewModel.cohortList
                                .map((String semester) => DropdownMenuItem(
                                      value: semester,
                                      child: Text(semester),
                                    ))
                                .toList(),
                            onChanged: (newValue) {
                              viewModel.setSelectedCohort(newValue.toString());
                            },
                          ))
                    ]),
                    verticalSpaceSmall,
                    StreamBuilder(
                        stream: viewModel.getGraduationList(
                            cohort: viewModel.selectedCohort!),
                        builder: (context, snapShot) {
                          if (snapShot.hasData) {
                            final students = snapShot.data!;
                            return GestureDetector(
                              onTap: () async {
                                var transcript =
                                  await  viewModel.generateGraduationList(
                                        students: students,
                                        cohort: viewModel.selectedCohort!);
                                final output = await getTemporaryDirectory();
                                final file =
                                    File('${output.path}/transcript.pdf');
                                await file
                                    .writeAsBytes(await transcript.save());
                                viewModel.setPdfPath(file.path);
                                viewModel.navigateToGraduationListView(
                                    cohort: viewModel.selectedCohort!);
                              },
                              child: Container(
                                height: 60,
                                width: MediaQuery.of(context).size.height,
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.black12, width: 0.6),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0.9),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(0, 3),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(5)),
                                child: const Center(
                                    child: Text(
                                  'View Graduation List',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                  ),
                                )),
                              ),
                            );
                          } else if (!snapShot.hasData ||
                              snapShot.data!.isEmpty) {
                            return const Text("No Students For this Cohort");
                          } else {
                            return SizedBox();
                          }
                        })
                  ],
                ),
                verticalSpaceMedium,
                const Text("Special Exams",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                verticalSpaceSmall,
                InkWell(
                  onTap: () {
                    viewModel.navigateToManageSpecialExams();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Text('Manage special exams',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          )),
                    ),
                  ),
                ),
                verticalSpaceMedium,
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  AdminPanelViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AdminPanelViewModel();
}
