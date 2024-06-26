import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'profile_item_model.dart';

class ProfileItem extends StackedView<ProfileItemModel> {
  const ProfileItem({super.key, required this.itemName, required this.icon});
  final String itemName;
  final IconData icon;
  @override
  Widget builder(
    BuildContext context,
    ProfileItemModel viewModel,
    Widget? child,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.black54,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          itemName,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }

  @override
  ProfileItemModel viewModelBuilder(
    BuildContext context,
  ) =>
      ProfileItemModel();
}
