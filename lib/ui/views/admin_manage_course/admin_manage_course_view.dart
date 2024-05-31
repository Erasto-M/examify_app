import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
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
    if (viewModel.isBusy) {
      return Center(child: CircularProgressIndicator());
    }

    final semesterOneCourses = viewModel.courses
        .where((course) => course.semesterStage.contains('S1'))
        .toList();
    final semesterTwoCourses = viewModel.courses
        .where((course) => course.semesterStage.contains('S2'))
        .toList();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Container(
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
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(width: 50),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Semester One",
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: semesterOneCourses.map((course) {
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
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          verticalSpaceSmall,
                          Text("Code: ${course.unitCode}"),
                          Text("L.Name: ${course.unitLecturerName}"),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      viewModel.showEditCourseBottomSheet(
                                        course: course,
                                        year: year,
                                      );
                                    },
                                    child: const Text('Edit'),
                                  ),
                                  horizontalSpaceMedium,
                                  ElevatedButton(
                                    onPressed: () {
                                      // viewModel.deleteCourse(course: course);
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Semester Two",
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
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
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          verticalSpaceSmall,
                          Text("Code: ${course.unitCode}"),
                          Text("L.ID: ${course.unitLecturerName}"),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                //Elevated button
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      viewModel.showEditCourseBottomSheet(
                                        course: course,
                                        year: year,
                                      );
                                    },
                                    child: const Text('Edit'),
                                  ),
                                  horizontalSpaceMedium,
                                  ElevatedButton(
                                    onPressed: () {
                                      // viewModel.deleteCourse(course: course);
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              )
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
          onPressed: () {
            viewModel.showAddUnitBottomSheet(year: year);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  @override
  AdminManageCourseViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AdminManageCourseViewModel();

  @override
  void onViewModelReady(AdminManageCourseViewModel viewModel) {
    viewModel.fetchCourses(year);
    super.onViewModelReady(viewModel);
  }
}
