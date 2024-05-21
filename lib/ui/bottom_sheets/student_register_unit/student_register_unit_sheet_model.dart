import 'package:examify/app/app.bottomsheets.dart';
import 'package:examify/app/app.locator.dart';
import 'package:examify/models/addUnit.dart';
import 'package:examify/services/student_dashboard_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StudentRegisterUnitSheetModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _studentDashboardService = locator<StudentDashboardService>();
  // get available unit

  Stream<List<AddUnitModel>> registerUnits() {
    return _studentDashboardService.fetchUnits();
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

  // send my registered units to firebase
  Future<AddUnitModel?> sendUnitsToFirebase() async {
    setBusy(true);
    if (selectedUnits.length < 2) {
      Fluttertoast.showToast(
          msg: "Choose Atleast 2 Units  for the current semester");
      setBusy(false);
    }
    await _studentDashboardService.myRegisteredUnits(selectedUnits);
    setBusy(false);
  }
}
