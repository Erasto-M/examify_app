import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_colors.dart';
import 'manage_courses_model.dart';

class ManageCourses extends StackedView<ManageCoursesModel> {
  const ManageCourses({super.key, required this.yearName});
  final String yearName;
  @override
  Widget builder(
    BuildContext context,
    ManageCoursesModel viewModel,
    Widget? child,
  ) {
    return GestureDetector(
      onTap: () {
        viewModel.navigateToCourses(yearName: yearName);
      },
      child: Container(
        height: 80,
        width: 80,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: primaryColor, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            yearName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  ManageCoursesModel viewModelBuilder(
    BuildContext context,
  ) =>
      ManageCoursesModel();
}
