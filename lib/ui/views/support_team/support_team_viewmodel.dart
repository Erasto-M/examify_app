import 'package:examify/app/app.dialogs.dart';
import 'package:examify/app/app.locator.dart';
import 'package:examify/app/app.router.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SupportTeamViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  void navigateToRegisterNewUser() {
    _navigationService.navigateToRegisterView();
  }

  Future<void> logout(BuildContext context) async {
    await _dialogService.showCustomDialog(
      variant: DialogType.confirmLogout,
      mainButtonTitle: 'Logout',
      barrierDismissible: false,
    );
  }
}
