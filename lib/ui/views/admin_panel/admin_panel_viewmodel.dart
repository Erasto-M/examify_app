import 'package:examify/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class AdminPanelViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  void navigateToRegisterNewUser() {
    _navigationService.navigateToRegisterView();
  }

  Future navigateToManageSpecialExams() async {
    _navigationService.navigateToCodSpecialExamsView();
  }
}
