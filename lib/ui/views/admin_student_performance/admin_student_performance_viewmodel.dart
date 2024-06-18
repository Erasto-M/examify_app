import 'package:examify/app/app.router.dart';
import 'package:examify/models/usersModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../services/authentication_service.dart';

class AdminStudentPerformanceViewModel extends BaseViewModel {
  final _authService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  TextEditingController searchController = TextEditingController();


  List<AppUser> usersList = [];
  get users => usersList;

  List<AppUser> _filteredUsers = [];
  get filteredUsers => _filteredUsers;


  void searchStudent() {
    String query = searchController.text.toLowerCase();
    usersList = users.where((user) {
      return user.userName.toLowerCase().contains(query) ||
          user.email.toLowerCase().contains(query);
    }).toList();
    notifyListeners();
  }

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
