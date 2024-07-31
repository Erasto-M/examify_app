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

  void setSelectedSemester(String semester) {
    _selectedSemester = semester;
    notifyListeners();
  }

  Stream<List<StudentsRegisteredUnitsModel>> get unitsStream =>
      _adminService.getUnitsForApproval(_selectedSemester);

  Future<void> approveUnitsForStudent(List<String> unitCodes, String studentId) async {
 print("unitcodes ${unitCodes}");
    setBusy(true);
    await _adminService.approveUnitsForStudent(unitCodes, studentId);
    setBusy(false);
  }
}
