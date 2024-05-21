import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/views/academics/academics_view.dart';
import 'package:examify/ui/views/lecturer_dashboard/lecturer_dashboard_view.dart';
import 'package:examify/ui/views/profile/profile_view.dart';
import 'package:examify/ui/views/student_dashboard/student_dashboard_view.dart';
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
          backgroundColor: Colors.grey[200],
          body: [
            const LecturerDashboardView(),
            const AcademicsView(),
            const ProfileView(),
          ][viewModel.currentIndexValue],
          bottomNavigationBar: BottomNavigationBar(
            onTap: viewModel.selectedIndex,
            currentIndex: viewModel.currentIndexValue,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: 'Academics',
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
  LecturerHomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LecturerHomeViewModel();
}
