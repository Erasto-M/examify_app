import 'package:examify/app/app.locator.dart';
import 'package:examify/models/student_registered_units.dart';
import 'package:examify/services/cod_dashboard_service.dart';
import 'package:stacked/stacked.dart';

class CodApproveUnitsViewModel extends BaseViewModel {
  final _adminService = locator<AdminDashboardService>();
  String _selectedSemester = 'Y1S1';
  final List<String> _semesters = [
    'Y1S1',
    'Y1S2',
    'Y2S1',
    'Y2S2',
    'Y3S1',
    'Y3S2',
    'Y4S1',
    'Y4S2'
  ];

  String get getselectedSemester => _selectedSemester;
  List<String> get semesters => _semesters;

  String _selectedCohort = '2024';
  final List<String> _cohorts = [
    "2020",
    "2021",
    "2022",
    "2023",
    "2024",
    "2025",
    "2026",
    "2027",
    "2028",
    "2029",
    "2030"
  ];

  String get getSelectedCohort => _selectedCohort;
  List<String> get cohorts => _cohorts;

  void setSelectedCohort(String cohort) {
    _selectedCohort = cohort;
    notifyListeners();
  }

  void setSelectedSemester(String semester) {
    _selectedSemester = semester;
    notifyListeners();
  }

  Stream<List<StudentsRegisteredUnitsModel>> get unitsStream =>
      _adminService.getUnitsForApproval(_selectedSemester, _selectedCohort);

  Future<void> approveUnitsForStudent(
      List<String> unitCodes, String studentId) async {
    
    setBusy(true);
    await _adminService.approveUnitsForStudent(unitCodes, studentId);
    setBusy(false);
  }
}
