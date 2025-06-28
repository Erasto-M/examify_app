import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/views/profile/profile_view.dart';
import 'package:examify/ui/views/student_academics/student_academics_view.dart';
import 'package:examify/ui/views/student_dashboard/student_dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: primaryColor,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ));
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: [
            const StudentDashboardView(),
            const StudentAcademicsView(),
            const ProfileView(),
          ][viewModel.currentIndexValue],
          bottomNavigationBar: BottomNavigationBar(
            onTap: viewModel.selectedIndex,
            currentIndex: viewModel.currentIndexValue,
            backgroundColor: Colors.white,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: 'Academic Reports',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            selectedItemColor: primaryColor,
          )),
    );
  }

  @override
  StudentsHomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StudentsHomeViewModel();
}
