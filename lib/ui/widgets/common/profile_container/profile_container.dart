import 'package:examify/ui/common/ui_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_colors.dart';
import 'profile_container_model.dart';

class ProfileContainer extends StackedView<ProfileContainerModel> {
  const ProfileContainer({super.key});

  @override
  Widget builder(
    BuildContext context,
    ProfileContainerModel viewModel,
    Widget? child,
  ) {
    return Container(
        margin: const EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height / 7,
        padding: const EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('Assets/Images/man1.jpeg'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Emmanuel Mutua',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      verticalSpaceTiny,
                      Text(
                        'itsdevem@gmail.com',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
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
