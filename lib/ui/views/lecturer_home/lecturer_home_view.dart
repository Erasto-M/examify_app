import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'lecturer_home_viewmodel.dart';

class LecturerHomeView extends StackedView<LecturerHomeViewModel> {
  const LecturerHomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LecturerHomeViewModel viewModel,
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
                      'Lecturer Home',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  @override
  LecturerHomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LecturerHomeViewModel();
}
