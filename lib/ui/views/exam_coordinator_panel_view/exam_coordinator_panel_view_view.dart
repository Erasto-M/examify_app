import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/common/manage_courses/manage_courses.dart';
import '../../widgets/common/transcripts/transcripts.dart';
import '../../widgets/common/users/users.dart';
import 'exam_coordinator_panel_view_viewmodel.dart';

class ExamCoordinatorPanelViewView
    extends StackedView<ExamCoordinatorPanelViewViewModel> {
  const ExamCoordinatorPanelViewView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ExamCoordinatorPanelViewViewModel viewModel,
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
                                'Hello, ExamsCo',
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

                verticalSpaceSmall,
                const Text(
                  'Users',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpaceTiny,
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      horizontalSpaceTiny,
                      Users(user: 'Students'),
                      horizontalSpaceTiny,
                      Users(user: 'Lecturers'),
                    ],
                  ),
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

                verticalSpaceSmall,
                // access marksheets
                InkWell(
                  onTap: () {
                    //navigate to marksheets
                    viewModel.navigateToMarksheets();
                  },
                  child: Container(
                    //text
                    height: MediaQuery.of(context).size.height / 7,
                    padding: const EdgeInsets.all(10.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Access Marksheets',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  ExamCoordinatorPanelViewViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ExamCoordinatorPanelViewViewModel();
}
