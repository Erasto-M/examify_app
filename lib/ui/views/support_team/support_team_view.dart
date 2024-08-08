import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/common/ui_helpers.dart';
import 'package:examify/ui/widgets/common/users/users.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'support_team_viewmodel.dart';

class SupportTeamView extends StackedView<SupportTeamViewModel> {
  const SupportTeamView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SupportTeamViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Support Team'),
        actions: [
          IconButton(
            onPressed: () {
              viewModel.logout(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                viewModel.navigateToRegisterNewUser();
              },
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12, width: 1),
                  color: primaryColor,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.white,
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 2),
                    )
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "Register New",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            verticalSpaceTiny,
            GestureDetector(
                onTap: () {
                  viewModel.navigateToStudents(user: "Students");
                }, child: const Users(user: 'Students')),
            horizontalSpaceTiny,
            GestureDetector(
                onTap: () {
                  viewModel.navigateToLecturers();
                }, child: const Users(user: 'Lecturers')),
          ],
        ),
      ),
    );
  }

  @override
  SupportTeamViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SupportTeamViewModel();
}
