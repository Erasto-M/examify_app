import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'students_home_viewmodel.dart';

class StudentsHomeView extends StackedView<StudentsHomeViewModel> {
  const StudentsHomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StudentsHomeViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Container(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 8,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    'Students Home',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  StudentsHomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StudentsHomeViewModel();
}
