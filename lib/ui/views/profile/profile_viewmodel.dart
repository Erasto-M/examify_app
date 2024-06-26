import 'package:examify/app/app.bottomsheets.dart';
import 'package:examify/app/app.dialogs.dart';
import 'package:examify/app/app.locator.dart';
import 'package:examify/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProfileViewModel extends BaseViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final _bottomsheetService = locator<BottomSheetService>();
  final _dialogService = locator<DialogService>();

  //logout method
  Future<void> logout(BuildContext context) async {
    await _dialogService.showCustomDialog(
      variant: DialogType.confirmLogout,
      mainButtonTitle: 'Logout',
      barrierDismissible: false,
    );
  }

  Map<String, dynamic> userDetails = {};
  Map<String, dynamic> get user => userDetails;
  // get current user details
  Future getCurrentUserDetails() async {
    userDetails = await _authenticationService.getCurrentUserDetails();
    notifyListeners();
  }

  // update profile bottom sheet
  void updateProfile() async {
    _bottomsheetService.showCustomSheet(
      variant: BottomSheetType.updateProfile,
      isScrollControlled: true,
    );
  }
}
