import 'package:examify/app/app.bottomsheets.dart';
import 'package:examify/app/app.locator.dart';
import 'package:examify/models/addUnit.dart';
import 'package:examify/models/student_registered_units.dart';
import 'package:examify/services/authentication_service.dart';
import 'package:examify/services/student_dashboard_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StudentRegisterUnitSheetModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _studentDashboardService = locator<StudentDashboardService>();
  final _authenticationService = locator<AuthenticationService>();
  // get available unit

  Stream<List<AddUnitModel>> registerUnits({required String semesterStage}) {
    return _studentDashboardService.fetchUnits(semesterStage: semesterStage);
  }

  List<AddUnitModel> selectedUnits = [];
  bool isUnitSelected(String unitId) {
    return selectedUnits.any((unit) => unit.unitId == unitId);
  }

  void updateUnitSelection(bool isSelected, AddUnitModel unit) {
    if (isSelected) {
      selectedUnits.add(unit);
    } else {
      selectedUnits
          .removeWhere((selectedUnit) => selectedUnit.unitId == unit.unitId);
    }
    notifyListeners(); // Notify listeners to update the UI
  }

  // get current user details
  Map<String, dynamic> userDetails = {};
  Map<String, dynamic> get user => userDetails;
  Future getCurrentUserDetails() async {
    userDetails = await _authenticationService.getCurrentUserDetails();
    notifyListeners();
  }

  // send my registered units to firebase
  Future<AddUnitModel?> sendUnitsToFirebase({
    required String unitName,
    required String unitCode,
    required String unitLecturer,
    required bool appliedSpecial,
    required String semesterStage,
  }) async {
    setBusy(true);
    if (selectedUnits.isEmpty) {
      Fluttertoast.showToast(
          msg: "Choose Atleast 2 Units  for the current semester");
      setBusy(false);
    }
    await _studentDashboardService
        .myRegisteredUnits(StudentsRegisteredUnitsModel(
      studentName: userDetails['userName'],
      studentEmail: userDetails['email'],
      studentPhoneNumber: userDetails['phoneNumber'],
      unitCode: unitCode,
      unitName: unitName,
      unitLecturer: unitLecturer,
      appliedSpecialExam: appliedSpecial,
      semesterStage: semesterStage,
    ));
    setBusy(false);
  }

  String _selectedSemesterStage = 'Y1S1';
  String get getSelectedSemesterStage => _selectedSemesterStage;
  void setSelectedSemesterStage(String value) {
    _selectedSemesterStage = value;
    notifyListeners();
  }

  // semester stages list
  List<String> semesterStages = [
    'Y1S1',
    'Y1S2',
    'Y2S1',
    'Y2S2',
    'Y3S1',
    'Y3S2',
    'Y4S1',
    'Y4S2',
  ];
}
