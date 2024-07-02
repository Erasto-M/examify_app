import 'package:stacked/stacked.dart';

import '../../../models/addUnit.dart';
import '../../../models/student_registered_units.dart';
import '../../../services/lecturer_dashboard_service.dart';

class EcAccessMarksSheetsViewModel extends BaseViewModel {
  final _lectureDashboardService = LecturerDashboardService();

  List<StudentsRegisteredUnitsModel>? _students;
  List<StudentsRegisteredUnitsModel>? get students => _students;

  String _selectedYear = '';
  String _selectedUnitToViewMarks = '';

  String get selectedUnitToGetMarks => _selectedUnitToViewMarks;

  List<AddUnitModel>? _unitsPerSelectedSemester;
  List<AddUnitModel>? get unitsPerSelectedSemester => _unitsPerSelectedSemester;

  void fetchUnits() {
    _lectureDashboardService.fetchUnits(semesterStage: _selectedYear).listen((units) {
      _unitsPerSelectedSemester = units;
      notifyListeners();
    });
  }

  List<String> years = [
    'Y1S1',
    'Y1S2',
    'Y2S1',
    'Y2S2',
    'Y3S1',
    'Y3S2',
    'Y4S1',
    'Y4S2'
  ];


  String get selectedYear => _selectedYear;

  void setSelectedYear(String year) {
    _selectedYear = year;
    notifyListeners();
    fetchUnits();
  }


  Stream<List<AddUnitModel>> fetchUnitsBasedOnYear() {
    return _lectureDashboardService.fetchUnits(semesterStage: _selectedYear);
  }

  void setSelectedExamModuleToEnterMarks(String value) {
    _selectedUnitToViewMarks = value;
    notifyListeners();
  }

  Stream<List<StudentsRegisteredUnitsModel>> getAllMyStudents({
    required String unitCode,
  }) {
    return _lectureDashboardService.getStudentsBasedOnUnitAndYear(
      unitCode: _selectedUnitToViewMarks,
      semesterStage: _selectedYear,
    );
  }
}
