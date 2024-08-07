import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'users_model.dart';

class Users extends StackedView<UsersModel> {
  const Users({super.key, required this.user});
  final String user;
  @override
  Widget builder(
    BuildContext context,
    UsersModel viewModel,
    Widget? child,
  ) {
      return Container(
        height: 60,
        width: MediaQuery.of(context).size.height / 5,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black12, width: 1),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.9),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 2),
              )
            ],
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            user,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      );
  }

  @override
  UsersModel viewModelBuilder(
    BuildContext context,
  ) =>
      UsersModel();
}
