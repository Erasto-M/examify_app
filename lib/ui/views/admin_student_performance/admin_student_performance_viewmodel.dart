import 'package:examify/app/app.router.dart';
import 'package:examify/models/addUnit.dart';
import 'package:examify/models/usersModel.dart';
import 'package:examify/services/cod_dashboard_service.dart';
import 'package:examify/services/lecturer_dashboard_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../models/student_registered_units.dart';
import '../../../services/authentication_service.dart';

class AdminStudentPerformanceViewModel extends BaseViewModel {
  final _authService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  final _lectureDashboardService = LecturerDashboardService();
  final _adminDashboardService = locator<AdminDashboardService>();

  TextEditingController searchController = TextEditingController();

  List<AppUser> usersList = [];
  get users => usersList;

  List<AppUser> _filteredUsers = [];
  get filteredUsers => _filteredUsers;

  String selectedSem = '';
  String get getSelectedSem => selectedSem;

   String selectedUnitCode = 'CCS 1105';
  String get getSelectedUnitCode => selectedSem;

  void setSelectedUnitCode(String value) {
    selectedUnitCode = value;
    notifyListeners();
  }

  String _selectedUnitToViewMarks = '';
  String get selectedUnitToGetMarks => _selectedUnitToViewMarks;

  List<AddUnitModel>? _unitsPerSelectedSemester;
  List<AddUnitModel>? get unitsPerSelectedSemester => _unitsPerSelectedSemester;

  void fetchUnits() {
    _lectureDashboardService
        .fetchUnits(semesterStage: selectedSem)
        .listen((units) {
      _unitsPerSelectedSemester = units;
      notifyListeners();
    });
  }

  void setSelectedSem(String value) {
    selectedSem = value;
    fetchUnits();
    notifyListeners();
  }

  void setInitSemValue(String yearName) {
    String currentSem = yearName.endsWith("one")
        ? "Y1S1"
        : yearName.endsWith("two")
            ? "Y2S1"
            : yearName.endsWith("three")
                ? "Y3S1"
                : "Y4S1";

    selectedSem = currentSem;
    fetchUnits();
    notifyListeners();
  }

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
    notifyListeners();
  }

  Stream<List<StudentsRegisteredUnitsModel>>
      fetchStudentsAccordingToYearStream({
    required String yearName,
    required String semesterStage,
  }) {
    String currentYearName = yearName.endsWith("one")
        ? "Y1"
        : yearName.endsWith("two")
            ? "Y2"
            : yearName.endsWith("three")
                ? "Y3"
                : "Y4";
    return _adminDashboardService.fetchStudentsAccordingToYearStream(
        yearName: currentYearName, semesterStage: semesterStage, unitCode: selectedUnitCode);
  }

  void checkPerformanceBasedOnCurrentYear(
      {required String semesterStage, required String? studentUid}) {
    _navigationService.navigateToAdminStudentPerformanceDetailsView(
        semesterStage: semesterStage, studentUid: studentUid!!);
  }

}
