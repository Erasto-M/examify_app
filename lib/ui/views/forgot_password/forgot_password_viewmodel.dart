import 'package:examify/app/app.locator.dart';
import 'package:examify/services/authentication_service.dart';
import 'package:examify/ui/views/forgot_password/forgot_password_view.form.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ForgotPasswordViewModel extends FormViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();
  //method to resend the password reset link
  Future<void> resendPasswordResetLink(
      {required String email, required BuildContext context}) async {
    setBusy(true);
    if (forgotPasswordEmailValue == null || forgotPasswordEmailValue!.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter your email address");
      setBusy(false);
      return;
    } else {
      await _authenticationService.forgotPassword(
          email: email, context: context);
      notifyListeners();
      setBusy(false);
    }
  }
}
