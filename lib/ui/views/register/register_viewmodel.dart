import 'dart:ui';

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

  String? selecteCohort;
  get selectedCohortValue => selecteCohort;

  //role list
  List role = [
    'Student',
    "Lecturer",
    "ExamsCoordinator",
  ];

  //cohost list
  List cohostList = [
    "2020",
    "2021",
    "2022",
    "2023",
    '2024',
    "2025",
    "2026",
    "2027",
    "2028",
    "2029",
    "2030",
    "2031",
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
  void selectRole(
      BuildContext context, TextEditingController cohortController) {
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
                  cohortController.text = valueItem;
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

  // select cohort
  void selectCohort(
      BuildContext context, TextEditingController roleController) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: cohostList.length,
            itemBuilder: (BuildContext context, int index) {
              String valueItem = cohostList[index];
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

  //select year of study
  String? _selectedYear;
  String? get selectedYear => _selectedYear;
  List<String> years = ["Y1", "Y2", "Y3", "Y4", "Y5"];
  void selectyear(BuildContext context, TextEditingController yearController) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: years.length,
            itemBuilder: (BuildContext context, int index) {
              String valueItem = years[index];
              return ListTile(
                title: Text(valueItem.toString()),
                onTap: () {
                  _selectedYear = valueItem;
                  yearController.text = valueItem.toString();
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
    required String yearOfStudy,
    required String registrationNumber,
    required String cohort,
    required String pfNumber,
  }) async {
    setBusy(true);
    if (passwordValue != confirmPasswordValue) {
      Fluttertoast.showToast(
          msg: 'Passwords do not match', backgroundColor: Colors.red);
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
      Fluttertoast.showToast(
          msg: 'All fields are required', backgroundColor: Colors.red);
      setBusy(false);
    } else if (roleValue == 'Student' &&
        (yearOfStudyValue == null || yearOfStudyValue == '')) {
      Fluttertoast.showToast(
          msg: 'Year of study is required', backgroundColor: Colors.red);
      setBusy(false);
    } else {
      await _authenticationService.createUser(
        email: email,
        userName: userName,
        role: role,
        phoneNumber: phoneNumber,
        gender: gender,
        password: password,
        yearOfStudy: yearOfStudy,
        registrationNumber: registrationNumber,
        pfNumber: pfNumber,
        cohort: cohort,
      );
      notifyListeners();
      setBusy(false);
    }
  }
}
