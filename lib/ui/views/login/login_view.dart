import 'dart:developer';

import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/common/ui_helpers.dart';
import 'package:examify/ui/views/login/login_view.form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'login_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'loginemail'),
  FormTextField(name: 'loginpassword'),
])
class LoginView extends StackedView<LoginViewModel> with $LoginView {
  LoginView({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget builder(
    BuildContext context,
    LoginViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: Colors.white,
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                          image: AssetImage("Assets/Images/logo1.jpeg"))),
                  margin: const EdgeInsets.only(top: 100.0),
                ),
              ),
              verticalSpaceSmall,
              const Text(
                ' Login to continue',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              verticalSpaceSmall,
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: MediaQuery.of(context).size.height / 1.4,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )),
                child: Column(
                  children: [
                    const Text(
                      "SIGN IN",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    verticalSpaceSmall,
                    Form(
                        key: formKey,
                        child: Column(
                          children: [
                            verticalSpaceTiny,
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty || value == '') {
                                  return "Email cannot be empty";
                                } else if (!value.contains("@")) {
                                  return "please enter a valid email address";
                                }
                                return '';
                              },
                              controller: loginemailController,
                              decoration: InputDecoration(
                                  hintText: " Email",
                                  prefixIcon: const Icon(Icons.email),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                            verticalSpaceTiny,
                            TextFormField(
                              controller: loginpasswordController,
                              obscureText: true,
                              validator: (value) {
                                if (value!.isEmpty || value == '') {
                                  return "Password cannot be empty";
                                } else if (value.length < 6) {
                                  return "Password must be at least 6 characters";
                                }
                                return '';
                              },
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  suffixIcon: const Icon(Icons.visibility_off),
                                  prefixIcon: const Icon(Icons.lock),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      viewModel.navigateToForgotPassword();
                                    },
                                    child: const Text("Forgot Password?"))
                              ],
                            ),
                            verticalSpaceTiny,
                            viewModel.isBusy
                                ? const SpinKitSpinningLines(
                                    color: primaryColor, size: 80)
                                : InkWell(
                                    onTap: () {
                                      viewModel.loginUser(
                                        email: loginemailController.text,
                                        password: loginpasswordController.text,
                                        context: context,
                                      );
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("LOGIN",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20)),
                                            horizontalSpaceSmall,
                                            Icon(Icons.arrow_forward_ios,
                                                color: Colors.white)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                            verticalSpaceSmall,
                          ],
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  LoginViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoginViewModel();
  @override
  void onViewModelReady(LoginViewModel viewModel) {
    syncFormWithViewModel(viewModel);
  }
}
