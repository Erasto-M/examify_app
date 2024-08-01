import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';

import 'admin_manage_course_viewmodel.dart';

class AdminManageCourseView extends StackedView<AdminManageCourseViewModel> {
  const AdminManageCourseView({Key? key, required this.year}) : super(key: key);

  final String year;

  @override
  Widget builder(
    BuildContext context,
    AdminManageCourseViewModel viewModel,
    Widget? child,
  ) {
    final semesterOneCourses = viewModel.courses
        .where((course) => course.semesterStage.contains('S1'))
        .toList();
    final semesterTwoCourses = viewModel.courses
        .where((course) => course.semesterStage.contains('S2'))
        .toList();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: viewModel.isBusy
            ? const Center(
                child: SpinKitSpinningLines(
                color: primaryColor,
                size: 50,
              ))
            : Container(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
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
                            year,
                            style: const TextStyle(
                              color: primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 50),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const Text("Semester One",
                                style:TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),  
                            Row(
                              children: [
                                Text(viewModel.isRegistrationWindowS1Open
                                    ? "Close registration window"
                                    : "Open registration window", style: const TextStyle(
                                      color: primaryColor,
                                      fontSize: 15, fontWeight: FontWeight.bold
                                    ),),
                                horizontalSpaceLarge,
                                Switch(
                                  value: viewModel.isRegistrationWindowS1Open,
                                  onChanged: (bool value) {
                                    viewModel.updateRegistrationWindowStatus(
                                        value, "${year}S1");
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: semesterOneCourses.map((course) {
                          return Container(
                            padding: const EdgeInsets.all(10.0),
                            margin: const EdgeInsets.only(bottom: 2),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.9),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name: ${course.unitName}",
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                verticalSpaceSmall,
                                Text("Code: ${course.unitCode}"),
                                Text("L.ID: ${course.unitLecturerName}"),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        viewModel.showEditCourseBottomSheet(
                                          course: course,
                                          year: year,
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                      ),
                                      child: const Text('Edit'),
                                    ),
                                    horizontalSpaceMedium,
                                    ElevatedButton(
                                      onPressed: () {
                                        // viewModel.deleteCourse(course: course);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                      ),
                                      child: const Text('Delete', style: TextStyle(
                                        color: Colors.red
                                      ),),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const Text("Semester Two",
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            Row(
                              children: [
                                Text(viewModel.isRegistrationWindowS1Open
                                    ? "Close registration window"
                                    : "Open registration window", 
                                    style: const TextStyle(
                                      color: primaryColor,
                                      fontSize: 15, fontWeight: FontWeight.bold)
                                    ),
                                horizontalSpaceLarge,
                                Switch(
                                  value: viewModel.isRegistrationWindowS2Open,
                                  onChanged: (bool value) {
                                    viewModel.updateRegistrationWindowStatus(
                                        value, "${year}S2");
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: semesterTwoCourses.map((course) {
                          return Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name: ${course.unitName}",
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                verticalSpaceSmall,
                                Text("Code: ${course.unitCode}"),
                                Text("L.ID: ${course.unitLecturerName}"),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        viewModel.showEditCourseBottomSheet(
                                          course: course,
                                          year: year,
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                      ),
                                      child: const Text('Edit'),
                                    ),
                                    horizontalSpaceMedium,
                                    ElevatedButton(
                                      onPressed: () {
                                        //viewModel.deleteCourse(course: course);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                      ),
                                      child: const Text('Delete', style: TextStyle(color: Colors.red),),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () {
            viewModel.showAddUnitBottomSheet(year: year);
          },
          
          child: const Icon(Icons.add, color: Colors.white,size: 30,),
        ),
      ),
    );
  }

  @override
  AdminManageCourseViewModel viewModelBuilder(BuildContext context) {
    return AdminManageCourseViewModel();
  }

  @override
  void onViewModelReady(AdminManageCourseViewModel viewModel) {
    viewModel.fetchCourses(year);
    viewModel.getRegistrationWindowStatusForSem1("${year}S1");
    viewModel.getRegistrationWindowStatusForSem2("${year}S2");
    super.onViewModelReady(viewModel);
  }
}
