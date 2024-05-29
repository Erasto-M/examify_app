import 'package:examify/app/app.locator.dart';
import 'package:examify/services/admin_dashboard_service.dart';
import 'package:stacked/stacked.dart';

class EditUnitSheetModel extends BaseViewModel {
  final _adminDashBoardServive = locator<AdminDashboardService>(); 
  late String _unitId;
  late String _unitName;

  init(String unitId, String unitName, String unitCode) {
    _unitId = unitId;
    _unitName = unitName;
  }

  void setUnitName(String unitName) {
    _unitName = unitName;
    notifyListeners();
  }

  Future<void> save(String unitCode) async {
    setBusy(true);
    try {
      await _adminDashBoardServive.editUnit(
        unitCode: unitCode,
        unitName: _unitName,
      );
    } catch (e) {
      // Handle error
    } finally {
      setBusy(false);
    }
  }
}

