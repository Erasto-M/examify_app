import 'package:examify/models/student_registered_units.dart';
import 'package:examify/ui/bottom_sheets/edit_marks_per_student/edit_marks_per_student_sheet.form.dart';
import 'package:flutter/material.dart';
import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import 'edit_marks_per_student_sheet_model.dart';

@FormView(fields: [
  FormTextField(name: 'assignMent1Marks'),
  FormTextField(name: 'assignMent2Marks'),
  FormTextField(name: 'cat1Marks'),
  FormTextField(name: 'cat2Marks'),
  FormTextField(name: 'examMarks'),
])
class EditMarksPerStudentSheet
    extends StackedView<EditMarksPerStudentSheetModel>
    with $EditMarksPerStudentSheet {
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
              controller: assignMent1MarksController,
              // initialValue: request.data['assignMent1Marks'].toString(),
              decoration: InputDecoration(
                labelText: 'Assignment 1',
                hintText: request.data['assignMent1Marks'].toString(),
              ),
            ),
            verticalSpaceSmall,
            TextFormField(
              controller: assignMent2MarksController,
              // initialValue: request.data['assignMent2Marks'].toString(),
              decoration: InputDecoration(
                labelText: 'Assignment 2',
                hintText: request.data['assignMent2Marks'].toString(),
              ),
            ),
            verticalSpaceSmall,
            TextFormField(
              controller: cat1MarksController,
              decoration: InputDecoration(
                labelText: 'CAT 1',
                hintText: request.data['cat1Marks'].toString(),
              ),
            ),
            verticalSpaceSmall,
            TextFormField(
              controller: cat2MarksController,
              // initialValue: request.data['cat2Marks'].toString(),
              decoration: InputDecoration(
                labelText: 'CAT 2',
                hintText: request.data['cat2Marks'].toString(),
              ),
            ),
            verticalSpaceSmall,
            verticalSpaceSmall,
            TextFormField(
              controller: examMarksController,
              // initialValue: request.data['examMarks'].toString(),
              decoration: InputDecoration(
                labelText: 'Exam',
                hintText: request.data['examMarks'].toString(),
              ),
            ),
            verticalSpaceLarge,
            InkWell(
              onTap: () async {
                await viewModel.updateMarks(
                  studentId: request.description!,
                  unitCode: request.data['unitCode'] as String,
                  student: StudentsRegisteredUnitsModel(
                    assignMent1Marks:
                        int.parse(assignMent1MarksController.text),
                    assignMent2Marks:
                        int.parse(assignMent2MarksController.text),
                    cat1Marks: int.parse(cat1MarksController.text),
                    cat2Marks: int.parse(cat2MarksController.text),
                    examMarks: int.parse(examMarksController.text),
                  ),
                  context: context,
                );
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(20)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Save Marks",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  EditMarksPerStudentSheetModel viewModelBuilder(BuildContext context) =>
      EditMarksPerStudentSheetModel();
  @override
  void onViewModelReady(EditMarksPerStudentSheetModel viewModel) {
    syncFormWithViewModel(viewModel);
  }
}
