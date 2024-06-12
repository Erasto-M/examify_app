import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/common/ui_helpers.dart';
import 'package:examify/ui/views/register/register_view.form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'register_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: "Name"),
  FormTextField(name: "Email"),
  FormTextField(name: "Phone Number"),
  FormTextField(name: "Gender"),
  FormTextField(name: "Role"),
  FormTextField(name: "Password"),
  FormTextField(name: "Year of study"),
  FormTextField(name: "Confirm Password"),
])
class RegisterView extends StackedView<RegisterViewModel> with $RegisterView {
  RegisterView({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget builder(
    BuildContext context,
    RegisterViewModel viewModel,
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
                'Create account to Get Things Done',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              verticalSpaceSmall,
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: MediaQuery.of(context).size.height / 0.99,
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
                      "SIGN UP",
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
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty || value == '') {
                                  return "Name is required";
                                }
                                return '';
                              },
                              controller: nameController,
                              decoration: InputDecoration(
                                  hintText: " Name",
                                  prefixIcon: const Icon(Icons.person),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                            verticalSpaceTiny,
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty || value == '') {
                                  return "Email is required";
                                } else if (!value.contains("@")) {
                                  return "please enter a valid email address";
                                }
                                return '';
                              },
                              controller: emailController,
                              decoration: InputDecoration(
                                  hintText: " Email",
                                  prefixIcon: const Icon(Icons.email),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                            verticalSpaceTiny,
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty || value == '') {
                                  return "Phone Number is required";
                                } else if (value.length < 10) {
                                  return "Phone Number must be 10 digits";
                                } else if (value
                                    .contains(RegExp(r'[a-zA-Z]'))) {
                                  return "Phone Number must be a number";
                                }
                                return '';
                              },
                              controller: phoneNumberController,
                              decoration: InputDecoration(
                                  hintText: "Phone Number",
                                  prefixIcon: const Icon(Icons.phone),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                            verticalSpaceTiny,
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty || value == '') {
                                  return "please select gender";
                                }
                                return '';
                              },
                              readOnly: true,
                              onTap: () {
                                viewModel.selectGender(
                                    context, genderController);
                              },
                              controller: genderController,
                              decoration: InputDecoration(
                                  hintText: "Gender",
                                  prefixIcon: const Icon(Icons.person),
                                  suffixIcon: const Icon(Icons.arrow_drop_down),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                            verticalSpaceTiny,
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty || value == '') {
                                  return "Role is required";
                                }
                                return '';
                              },
                              controller: roleController,
                              readOnly: true,
                              onTap: () {
                                viewModel.selectRole(context, roleController);
                              },
                              decoration: InputDecoration(
                                  hintText: "Role",
                                  suffixIcon: const Icon(Icons.arrow_drop_down),
                                  prefixIcon: const Icon(Icons.calendar_today),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                            verticalSpaceTiny,
                            if (roleController.text == 'Student')
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty || value == '') {
                                    return "Year of study is required";
                                  }
                                  return '';
                                },
                                controller: yearOfStudyController,
                                readOnly: true,
                                onTap: () {
                                  viewModel.selectyear(
                                      context, yearOfStudyController);
                                },
                                decoration: InputDecoration(
                                    hintText: "Year of study",
                                    suffixIcon:
                                        const Icon(Icons.arrow_drop_down),
                                    prefixIcon:
                                        const Icon(Icons.calendar_today),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              ),
                            verticalSpaceTiny,
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty || value == '') {
                                  return "Password is required";
                                } else if (value.length < 6) {
                                  return "Password must be at least 6 characters";
                                }
                                return '';
                              },
                              controller: passwordController,
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  suffixIcon: const Icon(Icons.visibility_off),
                                  prefixIcon: const Icon(Icons.lock),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                            verticalSpaceTiny,
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty || value == '') {
                                  return "Password is required";
                                } else if (value.length < 6) {
                                  return "Password must be at least 6 characters";
                                } else if (value != passwordController.text) {
                                  return "Passwords do not match";
                                }
                                return '';
                              },
                              controller: confirmPasswordController,
                              decoration: InputDecoration(
                                  hintText: "Confirm Password",
                                  suffixIcon: const Icon(Icons.visibility_off),
                                  prefixIcon: const Icon(Icons.lock),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                            verticalSpaceSmall,
                            viewModel.isBusy
                                ? const SpinKitSpinningLines(
                                    color: primaryColor,
                                    size: 80,
                                  )
                                : InkWell(
                                    onTap: () {
                                      viewModel.createUser(
                                          email: emailController.text,
                                          userName: nameController.text,
                                          role: roleController.text,
                                          phoneNumber:
                                              phoneNumberController.text,
                                          gender: genderController.text,
                                          yearOfStudy:
                                              yearOfStudyController.text,
                                          password: passwordController.text,
                                          confirmPassword:
                                              confirmPasswordController.text);
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
                                            Text("REGISTER",
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Already have an account?",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                                TextButton(
                                    onPressed: () {
                                      viewModel.navigateToLogin();
                                    },
                                    child: const Text("Login"))
                              ],
                            )
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
  RegisterViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RegisterViewModel();
  @override
  void onViewModelReady(RegisterViewModel viewModel) {
    syncFormWithViewModel(viewModel);
  }
}
