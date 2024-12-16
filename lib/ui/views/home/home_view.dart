import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:examify/ui/common/ui_helpers.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                verticalSpaceMedium,
                Text(
                  'Welcome to Examify',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpaceMedium,
                Text(
                  'This is the home screen of the app. You can add your widgets here.',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            )),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
