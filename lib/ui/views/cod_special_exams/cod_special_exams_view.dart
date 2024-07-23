import 'package:examify/ui/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'cod_special_exams_viewmodel.dart';

class CodSpecialExamsView extends StackedView<CodSpecialExamsViewModel> {
  const CodSpecialExamsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CodSpecialExamsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Manage Special Exams',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      ),
    );
  }

  @override
  CodSpecialExamsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CodSpecialExamsViewModel();
}
