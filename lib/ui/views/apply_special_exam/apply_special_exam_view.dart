import 'package:examify/ui/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'apply_special_exam_viewmodel.dart';

class ApplySpecialExamView extends StackedView<ApplySpecialExamViewModel> {
  const ApplySpecialExamView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ApplySpecialExamViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            viewModel.navigateBack();
          },
        ),
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        title: const Text(
          'Apply Special Exam',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      ),
    );
  }

  @override
  ApplySpecialExamViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ApplySpecialExamViewModel();
}
