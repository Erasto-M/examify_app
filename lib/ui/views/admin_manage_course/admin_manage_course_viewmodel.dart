import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examify/app/app.bottomsheets.dart';
import 'package:examify/models/addUnit.dart';
import 'package:examify/services/cod_dashboard_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class AdminManageCourseViewModel extends BaseViewModel {
  final _bottomSheetService = locator<BottomSheetService>();
  final _adminService = locator<AdminDashboardService>();

  bool isRegistrationWindowS1Open = false;
  bool isRegistrationWindowS2Open = false;

  List<AddUnitModel> _courses = [];
  List<AddUnitModel> get courses => _courses;

  Future<List<AddUnitModel>> fetchCourses(String year) async {
    setBusy(true);
    try {
      _courses = await _adminService.getUnits(year);
    } catch (e) {
      print('Error fetching courses: $e');
      _courses = [];
    }
    setBusy(false);
    return _courses;
  }

  void showAddUnitBottomSheet({required String year}) {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.addUnit,
      description: year,
      isScrollControlled: true,
      barrierDismissible: true,
    );
  }

  void showEditCourseBottomSheet({required AddUnitModel course, required String year}) {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.editUnit,
      description: year,
      isScrollControlled: true,
      barrierDismissible: true,
      data: course,
    );
  }

  Future<bool> getRegistrationWindowStatusForSem1(String year) async {
    setBusy(true);
    try {
      DocumentSnapshot? snapshot = await _adminService.getRegistrationWindowStatus(year);
      if (snapshot != null) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        if (data != null) {
          bool isOpen = data['${year}_opened'] ?? false;
          isRegistrationWindowS1Open = isOpen;
          setBusy(false);
          notifyListeners();
          return isOpen;
        }
      }
    } catch (e) {
      print('Error getting registration window status: $e');
    }
    setBusy(false);
    return false;
  }

  Future<bool> getRegistrationWindowStatusForSem2(String year) async {
    setBusy(true);
    try {
      DocumentSnapshot? snapshot = await _adminService.getRegistrationWindowStatus(year);
      if (snapshot != null) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        if (data != null) {
          bool isOpen = data['${year}_opened'] ?? false;
          isRegistrationWindowS2Open = isOpen;
          setBusy(false);
          notifyListeners();
          return isOpen;
        }
      }
    } catch (e) {
      print('Error getting registration window status: $e');
    }
    setBusy(false);
    return false;
  }

  Future<void> updateRegistrationWindowStatus(bool value, String year) async {
    setBusy(true);
    try {
      await _adminService.updateRegistrationWindowStatus(value, year);
      if (year.endsWith('S1')) {
        isRegistrationWindowS1Open = value;
      } else if (year.endsWith('S2')) {
        isRegistrationWindowS2Open = value;
      }
      notifyListeners();
    } catch (e) {
      print('Error updating registration window status: $e');
    }
    setBusy(false);
  }
}
