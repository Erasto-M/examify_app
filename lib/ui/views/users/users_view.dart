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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
        title: Text(
          user,
          style: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: DropdownButton<String>(
                value: viewModel.getSelectedCohort,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    viewModel.setSelectedCohort(newValue);
                  }
                },
                style: const TextStyle(color: Colors.white),
                dropdownColor: primaryColor,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                items: viewModel.cohorts
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Users",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<List<AppUser>>(
                stream: viewModel.getUsers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox();
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("Error loading users"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No users found"));
                  }

                  List<AppUser> users = snapshot.data!;
                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      AppUser user = users[index];
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
                            Text(
                              "Name: ${user.userName}",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            verticalSpaceSmall,
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
                                          user.phoneNumber ?? '1234567890',
                                    );
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
                    },
                  );
                },
              ),
            ),
          ],
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
    super.onViewModelReady(viewModel);
  }
}
