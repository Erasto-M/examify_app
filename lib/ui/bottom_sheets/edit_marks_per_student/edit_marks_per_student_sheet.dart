import 'package:flutter/material.dart';
import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'edit_marks_per_student_sheet_model.dart';

class EditMarksPerStudentSheet
    extends StackedView<EditMarksPerStudentSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const EditMarksPerStudentSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    EditMarksPerStudentSheetModel viewModel,
    Widget? child,
  ) {
    return SingleChildScrollView(
      child: Container(
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
              "Edit Marks for ${request.title}",
              style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  color: primaryColor),
            ),
            if (request.description != null) ...[
              verticalSpaceTiny,
              // Text(
              //   request.description!,
              //   style: const TextStyle(fontSize: 14, color: kcMediumGrey),
              //   maxLines: 3,
              //   softWrap: true,
              // ),
            ],
            verticalSpaceLarge,
            TextFormField(
              initialValue: request.data['assignMent1Marks'].toString(),
              decoration: const InputDecoration(labelText: 'Assignment 1'),
            ),
            verticalSpaceSmall,
            TextFormField(
              initialValue: request.data['assignMent2Marks'].toString(),
              decoration: const InputDecoration(labelText: 'Assignment 2'),
            ),
            verticalSpaceSmall,
            TextFormField(
              initialValue: request.data['cat1Marks'].toString(),
              decoration: const InputDecoration(labelText: 'CAT 1'),
            ),
            verticalSpaceSmall,
            TextFormField(
              initialValue: request.data['cat2Marks'].toString(),
              decoration: const InputDecoration(labelText: 'CAT 2'),
            ),
            verticalSpaceSmall,
            verticalSpaceSmall,
            TextFormField(
              initialValue: request.data['examMarks'].toString(),
              decoration: const InputDecoration(labelText: 'Exam'),
            ),
            verticalSpaceLarge,
          ],
        ),
      ),
    );
  }

  @override
  EditMarksPerStudentSheetModel viewModelBuilder(BuildContext context) =>
      EditMarksPerStudentSheetModel();
}
