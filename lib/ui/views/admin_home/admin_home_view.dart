import 'package:examify/ui/views/academics/academics_view.dart';
import 'package:examify/ui/views/admin_panel/admin_panel_view.dart';
import 'package:examify/ui/views/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import 'admin_home_viewmodel.dart';

class AdminHomeView extends StackedView<AdminHomeViewModel> {
  const AdminHomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AdminHomeViewModel viewModel,
    Widget? child,
  ) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: primaryColor,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ));
    return Scaffold(
        backgroundColor: Colors.white,
        body: [
          const AdminPanelView(),
          const AcademicsView(),
          const ProfileView(),
        ][viewModel.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: viewModel.currentIndex,
          onTap: viewModel.updateCurrentView,
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
        ));
  }

  @override
  AdminHomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AdminHomeViewModel();
}
