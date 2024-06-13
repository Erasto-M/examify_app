import 'package:examify/app/app.router.dart';
import 'package:examify/models/usersModel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../services/authentication_service.dart';

class AdminStudentPerformanceViewModel extends BaseViewModel {
  final _authService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();

  List<AppUser> usersList = [];

  get users => usersList;

  Future<void> fetchUsers({required String yearName}) async {
    String currentYearName = yearName.endsWith("one")
        ? "Y1"
        : yearName.endsWith("two")
        ? "Y2"
        : yearName.endsWith("three")
        ? "Y3"
        : "Y4";
    usersList = await _authService.fetchStudentsAccordingToYear(yearName: currentYearName);
    notifyListeners();
  }

  void checkPerformanceBasedOnCurrentYear(
      {required String semesterStage, required String? studentUid}) {
    _navigationService.navigateToAdminStudentPerformanceDetailsView(
        semesterStage: semesterStage, studentUid: studentUid!!);
  }
}
