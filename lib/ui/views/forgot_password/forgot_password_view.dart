import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/common/ui_helpers.dart';
import 'package:examify/ui/views/forgot_password/forgot_password_view.form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'forgot_password_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'forgotPasswordEmail'),
])
class ForgotPasswordView extends StackedView<ForgotPasswordViewModel>
    with $ForgotPasswordView {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ForgotPasswordViewModel viewModel,
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
                ' Forgot Your Password?',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              verticalSpaceMedium,
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
                      "Please enter your email to reset your password",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                    verticalSpaceSmall,
                    Form(
                        child: Column(
                      children: [
                        verticalSpaceTiny,
                        TextFormField(
                          controller: forgotPasswordEmailController,
                          decoration: InputDecoration(
                              hintText: " Email",
                              prefixIcon: const Icon(Icons.email),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        verticalSpaceMedium,
                        viewModel.isBusy
                            ? const SpinKitSpinningLines(
                                color: primaryColor,
                                size: 80,
                              )
                            : InkWell(
                                onTap: () {
                                  viewModel.resendPasswordResetLink(
                                    email: forgotPasswordEmailController.text,
                                    context: context,
                                  );
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Send Reset Link",
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
  ForgotPasswordViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ForgotPasswordViewModel();
  @override
  void onViewModelReady(ForgotPasswordViewModel viewModel) {
    syncFormWithViewModel(viewModel);
  }
}
