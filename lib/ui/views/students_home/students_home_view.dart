import 'package:examify/ui/common/ui_helpers.dart';
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
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height / 7,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                      child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            'Hello , Erastus ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          verticalSpaceSmall,
                          Text(
                            "10-04-2024  10:00 AM",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 40,
                        backgroundImage: AssetImage('Assets/Images/man1.jpeg'),
                      ),
                    ],
                  )),
                ),
                verticalSpaceSmall,
                const Row(
                  children: [
                    Text(
                      "My Courses",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                  ],
                )
              ],
            ),
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
