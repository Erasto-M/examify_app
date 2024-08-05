import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/common/ui_helpers.dart';
import 'package:examify/ui/views/register/register_view.form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  FormTextField(name: "Registration Number"),
  FormTextField(name: "Cohort"),
  FormTextField(name: "PF Number"),
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                verticalSpaceSmall,
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      'Please fill in the form below to create an account',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                verticalSpaceSmall,
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: MediaQuery.of(context).size.height / 1.00,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: Column(
                    children: [
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
                                        borderRadius:
                                            BorderRadius.circular(10))),
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
                                        borderRadius:
                                            BorderRadius.circular(10))),
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
                                        borderRadius:
                                            BorderRadius.circular(10))),
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
                                    suffixIcon:
                                        const Icon(Icons.arrow_drop_down),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
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
                                    suffixIcon:
                                        const Icon(Icons.arrow_drop_down),
                                    prefixIcon:
                                        const Icon(Icons.calendar_today),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
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
                              if (roleController.text == 'Student')
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty || value == '') {
                                      return "Cohort is required";
                                    }
                                    return '';
                                  },
                                  controller: cohortController,
                                  readOnly: true,
                                  onTap: () {
                                    viewModel.selectCohort(
                                        context, cohortController);
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Cohort",
                                      suffixIcon:
                                          const Icon(Icons.arrow_drop_down),
                                      prefixIcon:
                                          const Icon(Icons.calendar_today),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                              verticalSpaceTiny,
                              if (roleController.text == 'Student')
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty || value == '') {
                                      return "Registration number is required";
                                    }
                                    return '';
                                  },
                                  controller: registrationNumberController,
                                  readOnly: false,
                                  decoration: InputDecoration(
                                      hintText: "Registration Number",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                              verticalSpaceTiny,
                              if (roleController.text == 'Lecturer' ||
                                  roleController.text == 'ExamsCoordinator')
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty || value == '') {
                                      return "PF Number is required";
                                    }
                                    return '';
                                  },
                                  controller: pFNumberController,
                                  readOnly: false,
                                  decoration: InputDecoration(
                                      hintText: "PF Number",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
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
                                    suffixIcon:
                                        const Icon(Icons.visibility_off),
                                    prefixIcon: const Icon(Icons.lock),
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
                                  } else if (value != passwordController.text) {
                                    return "Passwords do not match";
                                  }
                                  return '';
                                },
                                controller: confirmPasswordController,
                                decoration: InputDecoration(
                                    hintText: "Confirm Password",
                                    suffixIcon:
                                        const Icon(Icons.visibility_off),
                                    prefixIcon: const Icon(Icons.lock),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
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
                                                confirmPasswordController.text,
                                            registrationNumber:
                                                registrationNumberController
                                                    .text,
                                            cohort: cohortController.text,
                                            pfNumber: pFNumberController.text,
                                            context: context);

                                        if (!viewModel.isBusy) {
                                          emailController.clear();
                                          nameController.clear();
                                          roleController.clear();
                                          phoneNumberController.clear();
                                          genderController.clear();
                                          yearOfStudyController.clear();
                                          passwordController.clear();
                                          confirmPasswordController.clear();
                                          registrationNumberController.clear();
                                          cohortController.clear();
                                          pFNumberController.clear();
                                        }
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
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
                                                      fontWeight:
                                                          FontWeight.bold,
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
