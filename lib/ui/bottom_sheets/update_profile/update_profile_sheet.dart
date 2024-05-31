import 'package:examify/ui/bottom_sheets/update_profile/update_profile_sheet.form.dart';
import 'package:flutter/material.dart';
import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/common/ui_helpers.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import 'update_profile_sheet_model.dart';

@FormView(fields: [
  FormTextField(name: 'updateUserName'),
  FormTextField(name: 'updateEmail'),
  FormTextField(name: 'updatePhoneNumber'),
  FormTextField(name: 'updateRole'),
])
class UpdateProfileSheet extends StackedView<UpdateProfileSheetModel>
    with $UpdateProfileSheet {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  UpdateProfileSheet({
    super.key,
    required this.completer,
    required this.request,
  });

  @override
  Widget builder(
    BuildContext context,
    UpdateProfileSheetModel viewModel,
    Widget? child,
  ) {
    Map<String, dynamic> userDetails = viewModel.user;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              request.title ?? 'Update Profile!!',
              style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  color: primaryColor),
            ),
          ),
          if (request.description != null) ...[
            verticalSpaceTiny,
            Text(
              request.description!,
              style: const TextStyle(fontSize: 14, color: kcMediumGrey),
              maxLines: 3,
              softWrap: true,
            ),
          ],
          verticalSpaceMedium,
          TextFormField(
            validator: (value) {
              if (value!.isEmpty || value == '') {
                return 'Please enter your username';
              }
              return null;
            },
            controller: updateUserNameController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.person),
              hintText: "${userDetails["userName"]}",
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
          verticalSpaceTiny,
          Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty || value == '') {
                        return 'Please enter your email';
                      } else if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    controller: updateEmailController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      hintText: '${userDetails["email"]}',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  verticalSpaceTiny,
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty || value == '') {
                        return 'Please enter your phone number';
                      } else if (value.length < 10) {
                        return 'Please enter a valid phone number';
                      } else if (value.contains(RegExp(r'[a-zA-Z]'))) {
                        return 'Please enter a valid phone number';
                      } else if (value.contains(
                          RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]'))) {
                        return 'Please enter a valid phone number';
                      }
                      return null;
                    },
                    controller: updatePhoneNumberController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone),
                      hintText: '${userDetails["phoneNumber"]}',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  verticalSpaceTiny,
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty || value == '') {
                        return 'Please enter your role';
                      }
                      return null;
                    },
                    controller: updateRoleController,
                    readOnly: true,
                    onTap: () {
                      viewModel.selectRole(context, updateRoleController);
                    },
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.work),
                        suffixIcon: const Icon(Icons.arrow_drop_down),
                        hintText: '${userDetails["role"]}',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        )),
                  ),
                  verticalSpaceMedium,
                  viewModel.isBusy
                      ? const SpinKitSpinningLines(
                          color: primaryColor,
                          size: 80,
                        )
                      : InkWell(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              return;
                            }
                            viewModel.updateUserProfile(
                              userName: updateUserNameController.text,
                              email: updateEmailController.text,
                              phoneNumber: updatePhoneNumberController.text,
                              role: updateRoleController.text,
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Update Profile",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  width: 15,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                ],
              )),
          verticalSpaceMedium,
        ],
      ),
    );
  }

  @override
  UpdateProfileSheetModel viewModelBuilder(BuildContext context) =>
      UpdateProfileSheetModel();
  @override
  void onViewModelReady(UpdateProfileSheetModel viewModel) {
    viewModel.getCurrentUserDetails();
    syncFormWithViewModel(viewModel);
    super.onViewModelReady(viewModel);
  }
}
