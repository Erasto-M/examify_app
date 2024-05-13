import 'package:examify/app/app.locator.dart';
import 'package:examify/app/app.router.dart';
import 'package:examify/services/authentication_service.dart';
import 'package:examify/ui/views/login/login_view.form.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends FormViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();
  //navigate to register
  Future<void> navigateToRegister() async {
    await _navigationService.navigateToRegisterView();
  }

  //Navigate to forgot password
  Future<void> navigateToForgotPassword() async {
    await _navigationService.navigateToForgotPasswordView();
  }

  // login user
  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    setBusy(true);
    if (loginemailValue!.isEmpty ||
        loginemailValue == '' ||
        loginpasswordValue!.isEmpty ||
        loginpasswordValue == '') {
      Fluttertoast.showToast(msg: 'Please fill all fields');
      setBusy(false);
    } else {
      await _authenticationService.loginUser(
        email: email,
        password: password,
      );
      setBusy(false);
    }
  }
}
