import 'package:examify/models/addUnit.dart';
import 'package:flutter/material.dart';
import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'edit_unit_sheet_model.dart';

class EditUnitSheet extends StackedView<EditUnitSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;

  const EditUnitSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    EditUnitSheetModel viewModel,
    Widget? child,
  ) {
    final course = request.data as AddUnitModel;

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
          Text(
            request.title ?? 'Edit Unit',
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
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
          verticalSpaceLarge,
          TextFormField(
            initialValue: course.unitName,
            decoration: const InputDecoration(labelText: 'Unit Name'),
            onChanged: viewModel.setUnitName,
          ),
          verticalSpaceSmall,
          Text('Unit Code: ${course.unitCode}', style: const TextStyle(fontSize: 16)),
          verticalSpaceSmall,
          Text('Lecturer: ${course.unitLecturerName}', style: const TextStyle(fontSize: 16)),
          verticalSpaceSmall,
          Text('Semester: ${course.semesterStage}', style: const TextStyle(fontSize: 16)),
          verticalSpaceSmall,
          Text('Year: ${course.year}', style: const TextStyle(fontSize: 16)),
          verticalSpaceLarge,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: viewModel.isBusy ? null : () async {
                  await viewModel.save();
                  completer!(SheetResponse(confirmed: true));
                },
                child: viewModel.isBusy ? CircularProgressIndicator() : Text('Save'),
              ),
              horizontalSpaceSmall,
              TextButton(
                onPressed: () => completer!(SheetResponse(confirmed: false)),
                child: const Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  EditUnitSheetModel viewModelBuilder(BuildContext context) => EditUnitSheetModel();
}
