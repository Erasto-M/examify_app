import 'package:examify/app/app.locator.dart';
import 'package:examify/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SupportTeamViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  void navigateToRegisterNewUser() {
    _navigationService.navigateToRegisterView();
  }
}
