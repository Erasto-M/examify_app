import 'package:examify/models/usersModel.dart';
import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/common/ui_helpers.dart';
import 'package:examify/ui/views/users_lecturers/users_lecturers_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class UsersLecturersView extends StackedView<UsersLecturersViewModel> {
  const UsersLecturersView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context,
      UsersLecturersViewModel viewModel,
      Widget? child,
      ) {
    List<AppUser> users = viewModel.users;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
                    const Text(
                      "Lecturers",
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 50),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Users",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: users.map((user) {
                      return Container(
                        padding: const EdgeInsets.all(10.0),
                        margin: const EdgeInsets.only(bottom: 2),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.9),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 2),
                            )
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StreamBuilder(
                                stream: viewModel
                                    .getEditingEnabledorDisabled(user.userId!),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data!.exists) {
                                    bool isEnabled =
                                        snapshot.data!['isEditingEnabled'] ??
                                            false;
                                    return Row(
                                      children: [
                                        Text(
                                          isEnabled
                                              ? "Marks editing disabled"
                                              : "Marks editing enabled",
                                          style: const TextStyle(
                                              color: primaryColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        horizontalSpaceLarge,
                                        Switch(
                                          value: isEnabled,
                                          onChanged: (bool value) {
                                            viewModel.disableOrEnableEditing(
                                                value, user.userId!);
                                          },
                                        ),
                                      ],
                                    );
                                  }
                                  return SizedBox();
                                }),

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
                            //row to have buttons to either email and call user
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    viewModel.email(
                                      email: user.email ?? 'example@gmail.com',
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    elevation: 5,
                                  ),
                                  child: const Text(
                                    'Email',
                                    style: TextStyle(color: primaryColor),
                                  ),
                                ),
                                horizontalSpaceMedium,
                                ElevatedButton(
                                  onPressed: () {
                                    viewModel.call(
                                        phoneNumber:
                                        user.phoneNumber ?? '1234567890');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    elevation: 5,
                                  ),
                                  child: const Text(
                                    'Call',
                                    style: TextStyle(color: primaryColor),
                                  ),
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
  UsersLecturersViewModel viewModelBuilder(
      BuildContext context,
      ) =>
      UsersLecturersViewModel();
  @override
  void onViewModelReady(UsersLecturersViewModel viewModel) {
    viewModel.getLecturers();
    super.onViewModelReady(viewModel);
  }
}