import 'package:examify/ui/common/ui_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_colors.dart';
import 'profile_container_model.dart';

class ProfileContainer extends StackedView<ProfileContainerModel> {
  const ProfileContainer(
      {super.key, required this.userName, required this.email});
  final String userName, email;
  @override
  Widget builder(
    BuildContext context,
    ProfileContainerModel viewModel,
    Widget? child,
  ) {
    return Container(
        margin: const EdgeInsets.all(10),
        height: 100,
        padding: const EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('Assets/Images/man1.jpeg'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      verticalSpaceTiny,
                      Text(
                        email,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  @override
  ProfileContainerModel viewModelBuilder(
    BuildContext context,
  ) =>
      ProfileContainerModel();
}
