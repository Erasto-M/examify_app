import 'package:examify/ui/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'admin_panel_viewmodel.dart';

class AdminPanelView extends StackedView<AdminPanelViewModel> {
  const AdminPanelView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AdminPanelViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 8,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      'Admin Panel',
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
          ),
        ),
      ),
    );
  }

  @override
  AdminPanelViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AdminPanelViewModel();
}
