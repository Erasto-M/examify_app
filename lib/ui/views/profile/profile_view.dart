import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/common/profile_container/profile_container.dart';
import '../../widgets/common/profile_item/profile_item.dart';
import 'profile_viewmodel.dart';

class ProfileView extends StackedView<ProfileViewModel> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ProfileViewModel viewModel,
    Widget? child,
    // get current user details
  ) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: primaryColor,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ));
    Map<String, dynamic> userDetails = viewModel.userDetails;
    print("userdetails: $userDetails ");
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                verticalSpaceSmall,
                ProfileContainer(
                    userName: userDetails["userName"] ?? "UserName",
                    email: userDetails["email"] ?? "Email"),
                verticalSpaceTiny,
                Container(
                  padding: const EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Personal Information',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              viewModel.updateProfile();
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {},
                        child: ProfileItem(
                          itemName: 'Name: ${userDetails['userName'] ?? ""}',
                          icon: Icons.person,
                        ),
                      ),
                      verticalSpaceSmall,
                      InkWell(
                        onTap: () {
                      
                        },
                        child: ProfileItem(
                          itemName:
                              'Phone: ${userDetails['phoneNumber'] ?? ""}',
                          icon: Icons.phone,
                        ),
                      ),
                      verticalSpaceSmall,
                      InkWell(
                        onTap: () {},
                        child: ProfileItem(
                          itemName: 'Email: ${userDetails['email'] ?? ""}',
                          icon: Icons.email,
                        ),
                      ),
                      verticalSpaceSmall,
                      InkWell(
                        onTap: () {},
                        child: ProfileItem(
                          itemName: 'Role: ${userDetails['role'] ?? ""}',
                          icon: Icons.work,
                        ),
                      ),
                      verticalSpaceSmall,
                      const Divider(
                        thickness: 1,
                      ),
                      verticalSpaceSmall,
                      InkWell(
                        onTap: () {},
                        child: const Text(
                          'Help',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      verticalSpaceSmall,
                      InkWell(
                        onTap: () {},
                        child: const ProfileItem(
                          itemName: 'Send Feedback',
                          icon: Icons.feedback,
                        ),
                      ),
                      verticalSpaceSmall,
                      InkWell(
                        onTap: () {},
                        child: const ProfileItem(
                          itemName: 'Report Problem',
                          icon: Icons.report,
                        ),
                      ),
                      verticalSpaceSmall,
                      InkWell(
                        onTap: () {},
                        child: const ProfileItem(
                          itemName: 'Bug Report',
                          icon: Icons.bug_report,
                        ),
                      ),
                      verticalSpaceSmall,
                      const Divider(
                        thickness: 1,
                      ),
                      verticalSpaceSmall,
                      const Text(
                        'About',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      verticalSpaceSmall,
                      InkWell(
                        onTap: () {},
                        child: const ProfileItem(
                          itemName: 'About app',
                          icon: Icons.info,
                        ),
                      ),
                      verticalSpaceSmall,
                      InkWell(
                        onTap: () {},
                        child: const ProfileItem(
                          itemName: 'Version: 1.0.0',
                          icon: Icons.info,
                        ),
                      ),
                      verticalSpaceSmall,
                      const Divider(
                        thickness: 1,
                      ),
                      verticalSpaceTiny,
                      InkWell(
                        onTap: () {
                          viewModel.logout(context);
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              'Logout',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  ProfileViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ProfileViewModel();

  @override
  void onViewModelReady(ProfileViewModel viewModel) {
    viewModel.getCurrentUserDetails();
    super.onViewModelReady(viewModel);
  }
}
