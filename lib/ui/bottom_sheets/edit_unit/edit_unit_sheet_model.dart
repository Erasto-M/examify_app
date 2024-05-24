import 'package:examify/app/app.locator.dart';
import 'package:examify/services/admin_dashboard_service.dart';
import 'package:stacked/stacked.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class EditUnitSheetModel extends BaseViewModel {
  final _adminDashBoardServive = locator<AdminDashboardService>(); 
  late String _unitId;
  late String _unitName;

  init(String unitId, String unitName) {
    _unitId = unitId;
    _unitName = unitName;
  }

  void setUnitName(String unitName) {
    _unitName = unitName;
    notifyListeners();
  }

  Future<void> save() async {
    setBusy(true);
    try {
      await _adminDashBoardServive.editUnit(
        unitId: _unitId,
        unitName: _unitName,
      );
    } catch (e) {
      // Handle error
    } finally {
      setBusy(false);
    }
  }
}

