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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          viewModel.showAddUnitBottomSheet(year: year);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  AdminManageCourseViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AdminManageCourseViewModel();
}
