import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'student_units_marks_viewmodel.dart';

class StudentUnitsMarksView extends StackedView<StudentUnitsMarksViewModel> {
  const StudentUnitsMarksView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StudentUnitsMarksViewModel viewModel,
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
  StudentUnitsMarksViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StudentUnitsMarksViewModel();
}
