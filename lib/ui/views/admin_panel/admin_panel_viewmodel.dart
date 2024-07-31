import 'package:examify/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../services/authentication_service.dart';

class AdminPanelViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();
  void navigateToRegisterNewUser() {
    _navigationService.navigateToRegisterView();
  }

  Future navigateToManageSpecialExams() async {
    _navigationService.navigateToCodSpecialExamsView();
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

  void navigateToApproveStudentUnits() {
    _navigationService.navigateToCodApproveUnitsView();
  }
}
