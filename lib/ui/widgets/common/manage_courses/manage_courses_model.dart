import 'package:examify/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.locator.dart';

class ManageCoursesModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  void navigateToCourses({required String yearName}) {
    _navigationService.navigateToAdminManageCourseView(year: yearName);
  }
}
