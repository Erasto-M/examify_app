import 'package:examify/models/usersModel.dart';
import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'users_viewmodel.dart';

class UsersView extends StackedView<UsersViewModel> {
  const UsersView({Key? key, required this.user}) : super(key: key);

  final String user;

  @override
  Widget builder(
    BuildContext context,
    UsersViewModel viewModel,
    Widget? child,
  ) {
    List<AppUser> users = viewModel.users;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Container(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: primaryColor,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      user,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(width: 50),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Users",
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: users.map((user) {
                      return Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name: ${user.userName}",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            verticalSpaceSmall,
                            // all other fields
                            Text(
                              "Email: ${user.email}",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            verticalSpaceSmall,
                            Text(
                              "Phone Number: ${user.phoneNumber}",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            verticalSpaceSmall,
                            Text(
                              "Role: ${user.role}",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            verticalSpaceSmall,
                            Text(
                              "User ID: ${user.userId}",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            //row to have buttons to either email and call user
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    // viewModel.email(
                                    //   email: user.email??'example@gmail.com',
                                    // );
                                  },
                                  child: const Text('Email'),
                                ),
                                horizontalSpaceMedium,
                                ElevatedButton(
                                  onPressed: () {
                                    // viewModel.call(
                                    //     phoneNumber: user.phoneNumber??'1234567890');
                                  },
                                  child: const Text('Call'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  UsersViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      UsersViewModel();
  @override
  void onViewModelReady(UsersViewModel viewModel) {
    viewModel.fetchUsers(user);
    super.onViewModelReady(viewModel);
  }
}
