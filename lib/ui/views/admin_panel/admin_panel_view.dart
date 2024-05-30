import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/common/manage_courses/manage_courses.dart';
import '../../widgets/common/transcripts/transcripts.dart';
import '../../widgets/common/users/users.dart';
import 'admin_panel_viewmodel.dart';

class AdminPanelView extends StackedView<AdminPanelViewModel> {
  const AdminPanelView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AdminPanelViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: MediaQuery.of(context).size.height / 7,
                    padding: const EdgeInsets.all(10.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello, Admin',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '10-04-2023 - 11:20AM',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            backgroundImage:
                                AssetImage('Assets/Images/man1.jpeg'),
                          ),
                        ],
                      ),
                    )),
                verticalSpaceMedium,
                const Text(
                  'Manage Courses',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpaceSmall,
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ManageCourses(yearName: 'Y1'),
                    ManageCourses(yearName: 'Y2'),
                    ManageCourses(yearName: 'Y3'),
                    ManageCourses(yearName: 'Y4'),
                  ],
                ),
                verticalSpaceSmall,
                const Text(
                  'Users',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpaceTiny,
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [Users(user: 'Students'), Users(user: 'Lecturers')],
                ),
                verticalSpaceSmall,
                const Text(
                  'Student Performance',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpaceTiny,
                const Column(
                  children: [
                    Transcripts(yearName: 'Year one'),
                    verticalSpaceTiny,
                    Transcripts(yearName: 'Year two'),
                    verticalSpaceTiny,
                    Transcripts(yearName: 'Year three'),
                    verticalSpaceTiny,
                    Transcripts(yearName: 'Year four'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  AdminPanelViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AdminPanelViewModel();
}
