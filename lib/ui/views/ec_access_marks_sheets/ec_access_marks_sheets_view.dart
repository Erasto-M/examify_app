import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'ec_access_marks_sheets_viewmodel.dart';

class EcAccessMarksSheetsView
    extends StackedView<EcAccessMarksSheetsViewModel> {
  const EcAccessMarksSheetsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    EcAccessMarksSheetsViewModel viewModel,
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
  EcAccessMarksSheetsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      EcAccessMarksSheetsViewModel();
}
