import 'package:examify/app/app.locator.dart';
import 'package:examify/app/app.router.dart';
import 'package:examify/models/addUnit.dart';
import 'package:examify/models/special_exams_model.dart';
import 'package:examify/models/student_registered_units.dart';
import 'package:examify/services/authentication_service.dart';
import 'package:examify/services/lecturer_dashboard_service.dart';
import 'package:examify/ui/views/lecturer_my_students/lecturer_my_students_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LecturerDashboardViewModel extends BaseViewModel {
  final _lecturerDashboardService = locator<LecturerDashboardService>();
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();

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

  //navigate to view my students
  Future navigateToViewStudents(
      {required String unitCode, required String unitName}) async {
    return await _navigationService.navigateToLecturerMyStudentsView(
      unitCode: unitCode,
      unitName: unitName,
    );
  }

  Stream<List<SpecialExamsModel>> mySpecialExamUnits() {
    return _lecturerDashboardService.getAllMyStudentSpecials();
  }
}
