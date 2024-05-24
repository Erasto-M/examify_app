import 'package:examify/app/app.bottomsheets.dart';
import 'package:examify/app/app.locator.dart';
import 'package:examify/models/addUnit.dart';
import 'package:examify/models/student_registered_units.dart';
import 'package:examify/services/authentication_service.dart';
import 'package:examify/services/student_dashboard_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StudentDashboardViewModel extends BaseViewModel {
  final _studentDashboardService = locator<StudentDashboardService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _authenticationService = locator<AuthenticationService>();
  void showRegisterUnitBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.studentRegisterUnit,
    );
  }

  Stream<List<StudentsRegisteredUnitsModel>> fetchMyUnits() {
    return _studentDashboardService.fetchAllMyUnits(
        semesterStage: getSelectedSemesterStage);
  }

  String _greeting = '';

  String get greeting => _greeting;

  StudentDashboardViewModel() {
    _updateGreeting();
    getCurrentUserDetails();
  }

  void _updateGreeting() {
    DateTime now = DateTime.now();
    _greeting = getGreeting(now);
    notifyListeners(); // Notify the UI that the greeting has changed
  }

  String getGreeting(DateTime now) {
    if (now.hour < 12) {
      return 'Good Morning';
    } else if (now.hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  Map<String, dynamic> userDetails = {};
  Map<String, dynamic> get user => userDetails;
  Future getCurrentUserDetails() async {
    userDetails = await _authenticationService.getCurrentUserDetails();
    notifyListeners();
  }

  String _selectedSemesterStage = 'Y1S1';
  String get getSelectedSemesterStage => _selectedSemesterStage;
  void setSelectedSemesterStage(String value) {
    _selectedSemesterStage = value;
    notifyListeners();
  }

  // semester stages list
  List<String> semesterStages = [
    'Y1S1',
    'Y1S2',
    'Y2S1',
    'Y2S2',
    'Y3S1',
    'Y3S2',
    'Y4S1',
    'Y4S2',
  ];
}
