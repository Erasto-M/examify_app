import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'admin_student_performance_viewmodel.dart';

class AdminStudentPerformanceView
    extends StackedView<AdminStudentPerformanceViewModel> {
  const AdminStudentPerformanceView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AdminStudentPerformanceViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      ),
    );
  }

  @override
  AdminStudentPerformanceViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AdminStudentPerformanceViewModel();
}
