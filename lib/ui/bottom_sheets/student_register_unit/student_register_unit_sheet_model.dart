import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examify/app/app.bottomsheets.dart';
import 'package:examify/app/app.locator.dart';
import 'package:examify/models/addUnit.dart';
import 'package:examify/models/student_registered_units.dart';
import 'package:examify/services/authentication_service.dart';
import 'package:examify/services/student_dashboard_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
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

  // List<AddUnitModel> selectedUnits = [];
  // bool isUnitSelected(String unitId) {
  //   return selectedUnits.any((unit) => unit.unitId == unitId);
  // }

  // get current user details
  Map<String, dynamic> userDetails = {};
  Map<String, dynamic> get user => userDetails;
  Future getCurrentUserDetails() async {
    userDetails = await _authenticationService.getCurrentUserDetails();
    notifyListeners();
  }

  // send my registered units to firebase
  Future<void> sendUnitsToFirebase(BuildContext context) async {
    final SelectedUnitsNotifier selectedUnitsNotifier =
        Provider.of<SelectedUnitsNotifier>(context, listen: false);
    setBusy(true);
    if (selectedUnitsNotifier.selectedUnitsList.length < 5) {
      Fluttertoast.showToast(
          msg: "Choose Atleast 5 Units for the current semester");
      setBusy(false);
      return; // Add return to exit the function early if no units are selected
    }

    List<StudentsRegisteredUnitsModel> unitsToRegister =
        selectedUnitsNotifier.selectedUnitsList.map((unit) {
      return StudentsRegisteredUnitsModel(
        studentName: userDetails['userName'],
        studentEmail: userDetails['email'],
        studentPhoneNumber: userDetails['phoneNumber'],
        unitCode: unit.unitCode,
        unitName: unit.unitName,
        unitLecturer: unit.unitLecturerId,
        appliedSpecialExam: false,
        isUnitApproved: false,
        semesterStage: unit.semesterStage,
        cohort: userDetails['cohort'],
      );
    }).toList();

    await _studentDashboardService.myRegisteredUnits(unitsToRegister);
    setBusy(false);
  }

  bool _hasRegisteredUnits = false;
  bool get hasRegisteredUnits => _hasRegisteredUnits;
  String _selectedSemesterStage = 'Y1S1';
  String get getSelectedSemesterStage => _selectedSemesterStage;
  void setSelectedSemesterStage(String value) {
    _selectedSemesterStage = value;
    checkIfUnitsRegistered();
    notifyListeners();
  }

  Future<void> checkIfUnitsRegistered() async {
    setBusy(true);
    final registeredUnits = await _studentDashboardService
        .fetchAllMyUnits(
          semesterStage: _selectedSemesterStage,
        )
        .first;

    _hasRegisteredUnits = registeredUnits.isNotEmpty;
    setBusy(false);
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


  Future<Map<String, bool>> fetchSemesterStageStatus() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = 
        await _studentDashboardService.getUnitRegistrationWindowStatus()!.first;

    // Casting data to Map<String, bool>
    Map<String, bool> semesterStatuses = 
        Map<String, bool>.from(snapshot.data() ?? {});
    
    return semesterStatuses;
  }

  // Method to check if the selected semester stage is open
  Future<bool> isSelectedSemesterStageOpen({required String selectedSemester}) async {
    Map<String, bool> semesterStatuses = await fetchSemesterStageStatus();
    return semesterStatuses[selectedSemester] ?? false;
  }
}
 

class SelectedUnitsNotifier extends ChangeNotifier {
  SelectedUnitsNotifier();
  List<AddUnitModel> selectedUnitsList = [];
  void addUnits(AddUnitModel unit) {
    selectedUnitsList.add(unit);
    notifyListeners();
  }

  void removeUnits(AddUnitModel unit) {
    selectedUnitsList.remove(unit);
    notifyListeners();
  }

  bool isUnitsSelected(String unitId) {
    return selectedUnitsList.any((unit) => unit.unitId == unitId);
  }

  void updateUnitSelection(bool isSelected, AddUnitModel unit) {
    if (isSelected) {
      selectedUnitsList.add(unit);
    } else {
      selectedUnitsList
          .removeWhere((selectedUnit) => selectedUnit.unitId == unit.unitId);
    }
  }

  void notifyListenersBatch() {
    notifyListeners();
  }
}
