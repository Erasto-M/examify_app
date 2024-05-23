import 'package:examify/app/app.locator.dart';
import 'package:examify/models/addUnit.dart';
import 'package:examify/services/lecturer_dashboard_service.dart';
import 'package:stacked/stacked.dart';

class LecturerDashboardViewModel extends BaseViewModel {
  final _lecturerDashboardService = locator<LecturerDashboardService>();

  List<AddUnitModel> _units = [];
  Map<String, bool> _containerVisibility = {};

  List<AddUnitModel> get units => _units;
  bool isContainerHidden(String id) => _containerVisibility[id] ?? true;

  void toggleContainer(String id) {
    _containerVisibility[id] = !(isContainerHidden(id));
    notifyListeners();
  }

  Future<List<AddUnitModel>> fetchLecturerUnits() async {
    return await _lecturerDashboardService.fetchLecturerUnits();
  }
}
