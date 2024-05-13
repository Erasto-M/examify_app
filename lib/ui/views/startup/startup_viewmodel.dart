import 'package:examify/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:examify/app/app.locator.dart';
import 'package:examify/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();

  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 3));

    // This is where you can make decisions on where your app should navigate when
    // you have custom startup logic
    await _authenticationService.getCurrentUser();
  }
}
