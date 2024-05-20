import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
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
  ) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpaceSmall,
                const ProfileContainer(),
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
                            onPressed: () {},
                            icon: const Icon(
                              Icons.edit,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const ProfileItem(
                        itemName: 'Name: Emmanuel Mutua',
                        icon: Icons.person,
                      ),
                      const ProfileItem(
                        itemName: 'Phone: 0712345678',
                        icon: Icons.phone,
                      ),
                      const ProfileItem(
                        itemName: 'Email: emmutua@gmail.com',
                        icon: Icons.email,
                      ),
                      const ProfileItem(
                        itemName: 'Role: Admin',
                        icon: Icons.work,
                      ),
                      const Text(
                        'Help',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const ProfileItem(
                        itemName: 'Send Feedback',
                        icon: Icons.feedback,
                      ),
                      const ProfileItem(
                        itemName: 'Report Problem',
                        icon: Icons.report,
                      ),
                      const ProfileItem(
                        itemName: 'Bug Report',
                        icon: Icons.bug_report,
                      ),
                      const Text(
                        'About',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const ProfileItem(
                        itemName: 'About app',
                        icon: Icons.info,
                      ),
                      const ProfileItem(
                        itemName: 'Version: 1.0.0',
                        icon: Icons.info,
                      ),
                      verticalSpaceSmall,
                      Container(
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
}
