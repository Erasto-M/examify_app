import 'package:examify/app/app.locator.dart';
import 'package:examify/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ConfirmLogoutDialogModel extends BaseViewModel {
  final _authenticationService = locator<AuthenticationService>();

  Future<void> logout({required BuildContext context}) async {
    await _authenticationService.signOutUser(context: context);
  }
}
