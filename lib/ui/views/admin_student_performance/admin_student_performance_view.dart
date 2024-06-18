import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../models/usersModel.dart';
import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import 'admin_student_performance_viewmodel.dart';

class AdminStudentPerformanceView
    extends StackedView<AdminStudentPerformanceViewModel> {
  const AdminStudentPerformanceView({Key? key, required this.yearName})
      : super(key: key);
  final String yearName;

  @override
  Widget builder(
      BuildContext context,
      AdminStudentPerformanceViewModel viewModel,
      Widget? child,
      ) {
    List<AppUser> users = viewModel.users;
    String currentYearName = yearName.endsWith("one")
        ? "Y1"
        : yearName.endsWith("two")
        ? "Y2"
        : yearName.endsWith("three")
        ? "Y3"
        : "Y4";

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Container(
          padding: const EdgeInsets.all(10),
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
                    "Student Performance",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(width: 50),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "$yearName Students",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  controller: viewModel.searchController,
                  decoration: InputDecoration(
                    hintText: "Search for a student",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        viewModel.searchStudent();
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onSubmitted: (value) {
                    viewModel.searchStudent();
                  },
                ),
              ),
              verticalSpaceSmall,
              viewModel.isBusy
                  ? Expanded(
                child: Center(child: CircularProgressIndicator()),
              )
                  : Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    AppUser user = users[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name: ${user.userName}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          verticalSpaceSmall,
                          Text(
                            "Email: ${user.email}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          verticalSpaceMedium,
                          const Text("View Performance"),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  viewModel
                                      .checkPerformanceBasedOnCurrentYear(
                                    semesterStage:
                                    "${currentYearName}S1",
                                    studentUid: user.userId,
                                  );
                                },
                                child: Text("${currentYearName}S1"),
                              ),
                              horizontalSpaceMedium,
                              ElevatedButton(
                                onPressed: () {
                                  viewModel
                                      .checkPerformanceBasedOnCurrentYear(
                                    semesterStage:
                                    "${currentYearName}S2",
                                    studentUid: user.userId,
                                  );
                                },
                                child: Text("${currentYearName}S2"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  AdminStudentPerformanceViewModel viewModelBuilder(
      BuildContext context,
      ) =>
      AdminStudentPerformanceViewModel();

  @override
  void onViewModelReady(AdminStudentPerformanceViewModel viewModel) {
    viewModel.fetchUsers(yearName: yearName);
    super.onViewModelReady(viewModel);
  }
}
