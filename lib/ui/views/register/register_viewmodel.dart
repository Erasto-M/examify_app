import 'package:examify/app/app.locator.dart';
import 'package:examify/app/app.router.dart';
import 'package:examify/services/authentication_service.dart';
import 'package:examify/ui/views/register/register_view.form.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RegisterViewModel extends FormViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();
  //gender list
  List gender = [
    'Male',
    "Female",
    "binary",
    "other",
  ];
  //selected role & gender getter
  String? selectedgender;
  get selectedGenderValue => selectedgender;
  String? selectedRole;
  get selectedRoleValue => selectedRole;

  //role list
  List role = [
    'Student',
    "Lecturer",
  ];
  // gender drop down menu
  void selectGender(
      BuildContext context, TextEditingController genderController) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: gender.length,
            itemBuilder: (BuildContext context, int index) {
              String valueItem = gender[index];
              return ListTile(
                title: Text(valueItem),
                onTap: () {
                  selectedgender = valueItem;
                  genderController.text = valueItem;
                  notifyListeners();
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  // select role
  void selectRole(BuildContext context, TextEditingController roleController) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: role.length,
            itemBuilder: (BuildContext context, int index) {
              String valueItem = role[index];
              return ListTile(
                title: Text(valueItem),
                onTap: () {
                  selectedRole = valueItem;
                  roleController.text = valueItem;
                  notifyListeners();
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  //navigate to login
  Future<void> navigateToLogin() async {
    await _navigationService.navigateToLoginView();
  }

  // create user method
  Future<void> createUser({
    required String email,
    required String userName,
    required String role,
    required String phoneNumber,
    required String gender,
    required String password,
    required String confirmPassword,
  }) async {
    setBusy(true);
    if (passwordValue != confirmPasswordValue) {
      Fluttertoast.showToast(msg: 'Passwords do not match');
      setBusy(false);
      return;
    } else if (nameValue!.isEmpty ||
        nameValue! == '' ||
        emailValue!.isEmpty ||
        emailValue! == '' ||
        phoneNumberValue!.isEmpty ||
        phoneNumberValue! == '' ||
        genderValue!.isEmpty ||
        genderValue == '' ||
        roleValue!.isEmpty ||
        roleValue == '' ||
        passwordValue!.isEmpty ||
        passwordValue! == '' ||
        confirmPasswordValue!.isEmpty ||
        confirmPasswordValue! == '') {
      Fluttertoast.showToast(msg: 'All fields are required');
      setBusy(false);
    } else {
      await _authenticationService.createUser(
        email: email,
        userName: userName,
        role: role,
        phoneNumber: phoneNumber,
        gender: gender,
        password: password,
      );
      notifyListeners();
      setBusy(false);
    }
  }
}
