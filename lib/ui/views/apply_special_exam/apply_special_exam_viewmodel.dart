import 'package:examify/app/app.locator.dart';
import 'package:examify/models/addUnit.dart';
import 'package:examify/models/student_registered_units.dart';
import 'package:examify/services/student_dashboard_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ApplySpecialExamViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _studentDashboardService = locator<StudentDashboardService>();

  //navigate back
  void navigateBack() {
    _navigationService.back();
    notifyListeners();
  }

  String? _selectedSemesterStage = 'Y1S1';
  String? get selectedSemesterStage => _selectedSemesterStage;

  void setSelectedSemesterStage(String value) {
    _selectedSemesterStage = value;
    notifyListeners();
  }

  bool _isSpecialExamApplied = false;
  bool? get getIsSpecialExamApplied => _isSpecialExamApplied;

  void SetSpecialExamApplied(bool value) {
    _isSpecialExamApplied = value;
    notifyListeners();
  }

  Stream<List<StudentsRegisteredUnitsModel>> fetchMyUnits() {
    return _studentDashboardService.fetchAllMyUnits(
        semesterStage: selectedSemesterStage!);
  }

  // list of selected units
  List<StudentsRegisteredUnitsModel> selectedUnits = [];
  List<StudentsRegisteredUnitsModel> get getSelectedUnits => selectedUnits;
  bool isUnitSelected(String unitCode) {
    return selectedUnits.any((unit) => unit.unitCode == unitCode);
  }

  void updateSelectedUnits(
      bool isUnitSelected, StudentsRegisteredUnitsModel unit) {
    if (isUnitSelected) {
      selectedUnits.add(unit);
    } else {
      selectedUnits.removeWhere(
          (selectedUnit) => selectedUnit.unitCode == unit.unitCode);
    }
    notifyListeners();
  }
}
