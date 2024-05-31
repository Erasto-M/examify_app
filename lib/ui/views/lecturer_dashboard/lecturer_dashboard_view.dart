import 'package:examify/models/addUnit.dart';
import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/common/ui_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';

import 'lecturer_dashboard_viewmodel.dart';

class LecturerDashboardView extends StackedView<LecturerDashboardViewModel> {
  const LecturerDashboardView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LecturerDashboardViewModel viewModel,
    Widget? child,
  ) {
    DateTime now = DateTime.now();
    String greeting = viewModel.getGreeting(now);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Container(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height / 7,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                    child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          '${greeting} , ',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        verticalSpaceTiny,
                        Text(
                          viewModel.userDetails["userName"] ?? "UserName",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "${now.day}-${now.month}-${now.year}  ${now.hour}: ${now.minute} ${now.hour > 12 ? "PM" : "AM"}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 40,
                      backgroundImage: AssetImage('Assets/Images/man1.jpeg'),
                    ),
                  ],
                )),
              ),
              verticalSpaceSmall,
              const Text(
                "Courses Lectured",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              verticalSpaceMedium,
              Expanded(
                flex: 1,
                child: FutureBuilder(
                  future: viewModel.fetchLecturerUnits(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SpinKitSpinningLines(
                          color: primaryColor,
                          size: 80,
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          AddUnitModel unit = snapshot.data![index];
                          return Card(
                            child: ListTile(
                              title: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(unit.unitCode),
                                      verticalSpaceTiny,
                                      // put text in a wrap widegt
                                      Column(
                                        children: [
                                          Text(
                                            unit.unitName,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      viewModel.toggleContainer(unit.unitId!);
                                    },
                                    icon: viewModel.isContainerHidden(
                                                unit.unitId!) ==
                                            true
                                        ? const Icon(
                                            Icons.arrow_drop_down_outlined)
                                        : const Icon(
                                            Icons.arrow_drop_up_outlined),
                                  ),
                                ],
                              ),
                              subtitle:
                                  viewModel.isContainerHidden(unit.unitId!) ==
                                          true
                                      ? const SizedBox()
                                      : Center(
                                          child: Container(
                                              height: 50,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  'View Students',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              )),
                                        ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  LecturerDashboardViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LecturerDashboardViewModel();
  @override
  void onViewModelReady(LecturerDashboardViewModel viewModel) {
    viewModel.getCurrentUserDetails();
    super.onViewModelReady(viewModel);
  }
}
