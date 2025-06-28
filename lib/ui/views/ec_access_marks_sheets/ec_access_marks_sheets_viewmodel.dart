import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examify/services/cod_dashboard_service.dart';
import 'package:stacked/stacked.dart';

import '../../../models/addUnit.dart';
import '../../../models/student_registered_units.dart';
import '../../../services/lecturer_dashboard_service.dart';

class EcAccessMarksSheetsViewModel extends BaseViewModel {
  final _lectureDashboardService = LecturerDashboardService();
  final _adminService = AdminDashboardService();

  List<StudentsRegisteredUnitsModel>? _students;
  List<StudentsRegisteredUnitsModel>? get students => _students;

  String _selectedSemester = 'Y1S1'; // Default to a valid value
  String _selectedUnitToViewMarks = '';

  String get selectedUnitToGetMarks => _selectedUnitToViewMarks;

  List<AddUnitModel>? _unitsPerSelectedSemester;
  List<AddUnitModel>? get unitsPerSelectedSemester => _unitsPerSelectedSemester;

  void fetchUnits() {
    _lectureDashboardService
        .fetchUnits(semesterStage: _selectedSemester)
        .listen((units) {
      if (units.isEmpty) {
        
      }
      _unitsPerSelectedSemester = units;
      if (units.isNotEmpty) {
        setSelectedUnitToGetMarks(units[0].unitCode);
      }
      notifyListeners();
    }).onError((error) {
      throw Exception(error.toString());
    });
  }

  List<String> years = [
    'Y1S1',
    'Y1S2',
    'Y1',
    'Y2S1',
    'Y2S2',
    'Y2',
    'Y3S1',
    'Y3S2',
    'Y3',
    'Y4S1',
    'Y4S2',
    'Y4'
  ];

  String get selectedSemester => _selectedSemester;

  void setSelectedSemester({required String semester}) {
    _selectedSemester = semester;
    fetchUnits();
    notifyListeners();
  }

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

  Stream<List<AddUnitModel>> fetchUnitsBasedOnYear() {
    return _lectureDashboardService.fetchUnits(
        semesterStage: _selectedSemester);
  }

  void setSelectedUnitToGetMarks(String value) {
    _selectedUnitToViewMarks = value;
    notifyListeners();
  }

  Stream<List<StudentsRegisteredUnitsModel>> getAllMyStudents({
    required String unitCode,
  }) {
    return _lectureDashboardService.getStudentsBasedOnUnitAndYear(
      unitCode: unitCode,
      semesterStage: _selectedSemester,
      cohort: _selectedCohort,
    );
  }

  Future<DocumentSnapshot?> getReportsAvailabilityStatus() async {
    try {
      return await _adminService.getReportsAvailabilityStatus();
    } catch (e) {
      
      throw Exception(e.toString());
    }
  }

  Future<void> updateReportsAvailabilityStatus(
      bool value, String selectedYear) async {
    try {
      await _adminService.updateReportsAvailabilityStatus(value, selectedYear);
      notifyListeners();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
