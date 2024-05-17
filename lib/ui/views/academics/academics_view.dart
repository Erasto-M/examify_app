import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'academics_viewmodel.dart';

class AcademicsView extends StackedView<AcademicsViewModel> {
  const AcademicsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AcademicsViewModel viewModel,
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
  AcademicsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AcademicsViewModel();
}
