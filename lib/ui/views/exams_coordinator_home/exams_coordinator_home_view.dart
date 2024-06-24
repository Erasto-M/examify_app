import 'package:examify/ui/views/exam_coordinator_panel_view/exam_coordinator_panel_view_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../academics/academics_view.dart';
import '../profile/profile_view.dart';
import 'exams_coordinator_home_viewmodel.dart';

class ExamsCoordinatorHomeView
    extends StackedView<ExamsCoordinatorHomeViewModel> {
  const ExamsCoordinatorHomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ExamsCoordinatorHomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: [
          const ExamCoordinatorPanelViewView(),
          const AcademicsView(),
          const ProfileView(),
        ][viewModel.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
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
  ExamsCoordinatorHomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ExamsCoordinatorHomeViewModel();
}
