import 'package:examify/app/app.bottomsheets.dart';
import 'package:examify/app/app.locator.dart';
import 'package:examify/models/addUnit.dart';
import 'package:examify/models/student_registered_units.dart';
import 'package:examify/services/authentication_service.dart';
import 'package:examify/services/lecturer_dashboard_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LecturerMyStudentsViewModel extends BaseViewModel {
  //initializing the services
  final _lectureDashboardService = locator<LecturerDashboardService>();
  final _authenticationService = locator<AuthenticationService>();
  final _lecturerDashboardService = locator<LecturerDashboardService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _navigaationService = locator<NavigationService>();
  //gettiong the current user details
  Map<String, dynamic> userDetails = {};
  Map<String, dynamic> get user => userDetails;
  Future getCurrentUserDetails() async {
    userDetails = await _authenticationService.getCurrentUserDetails();
    notifyListeners();
  }

  List<AddUnitModel>? _lecturerUnits;
  List<AddUnitModel>? get lecturerUnits => _lecturerUnits;

  List<String> unitCodes = [];
  List<String> unitNames = [];
  Future<List<AddUnitModel>?> fetchLecturerUnits() async {
    _lecturerUnits = await _lecturerDashboardService.fetchLecturerUnits();
    if (_lecturerUnits != null && _lecturerUnits!.isNotEmpty) {
      unitCodes = _lecturerUnits!.map((unit) => unit.unitCode).toList();
      unitNames = _lecturerUnits!.map((unit) => unit.unitName).toList();
      print("unitcodes: ${unitCodes}");
      print("unitnames: ${unitNames}");
    }
  }

  List<StudentsRegisteredUnitsModel>? _students;
  List<StudentsRegisteredUnitsModel>? get students => _students;

  Stream<List<StudentsRegisteredUnitsModel>> getAllMyStudents({
    required String unitCode,
  }) {
    return _lectureDashboardService.getAllMyStudents(unitCode: unitCode);
  }

  // open the bottom sheet to edit the student marks
  void openEditStudentMarksSheet({
    required String unitCode,
    required String unitName,
  }) {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.editStudentMarks,
      isScrollControlled: true,
      description: _selectedExamModuleToEnterMarks,
      data: unitCode,
    );
  }

  String _selectedExamModuleToEnterMarks = 'assignMent1Marks';
  String get selectedExamModuleToEnterMarks => _selectedExamModuleToEnterMarks;
  void setSelectedExamModuleToEnterMarks(String value) {
    _selectedExamModuleToEnterMarks = value;
    notifyListeners();
  }

  List<String> examModelues = [
    'assignMent1Marks',
    "assignMent2Marks",
    "cat1Marks",
    "cat2Marks",
    "examMarks",
  ];
  Future<void> backToHome() async {
    await _navigaationService.back();
    notifyListeners();
  }
}
