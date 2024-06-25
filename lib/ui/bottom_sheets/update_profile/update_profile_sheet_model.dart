import 'package:examify/app/app.locator.dart';
import 'package:examify/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class UpdateProfileSheetModel extends FormViewModel {
  final _authenticationService = locator<AuthenticationService>();
  Map<String, dynamic> userDetails = {};
  Map<String, dynamic> get user => userDetails;

  Future getCurrentUserDetails() async {
    userDetails = await _authenticationService.getCurrentUserDetails();
    notifyListeners();
  }

  // update user profile
  Future<void> updateUserProfile({
    required String userName,
    required String email,
    required String phoneNumber,
  }) async {
    setBusy(true);
    await _authenticationService.updateUserProfile(
      userName: userName,
      email: email,
      phoneNumber: phoneNumber,
    );
    setBusy(false);
  }

  // selected role getter
  String? selectedRole;
  get selectedRoleValue => selectedRole;

  List role = [
    'Student',
    "Lecturer",
  ];
  // gender drop down menu
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
}
