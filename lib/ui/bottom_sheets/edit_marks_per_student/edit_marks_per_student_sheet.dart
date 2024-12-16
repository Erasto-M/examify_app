import 'package:examify/models/student_registered_units.dart';
import 'package:examify/ui/bottom_sheets/edit_marks_per_student/edit_marks_per_student_sheet.form.dart';
import 'package:flutter/material.dart';
import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/common/ui_helpers.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    super.key,
    required this.completer,
    required this.request,
  });

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
                labelText: 'Assignment1 / ${request.data['assignMent1OutOff']}',
                hintText: request.data['assignMent1Marks'].toString(),
              ),
            ),
            verticalSpaceSmall,
            TextFormField(
              controller: assignMent2MarksController,
              // initialValue: request.data['assignMent2Marks'].toString(),
              decoration: InputDecoration(
                labelText: 'Assignment2 / ${request.data['assignMent2OutOff']}',
                hintText: request.data['assignMent2Marks'].toString(),
              ),
            ),
            verticalSpaceSmall,
            TextFormField(
              controller: cat1MarksController,
              decoration: InputDecoration(
                labelText: 'CAT1 / ${request.data['cat1MarksOutOff']}',
                hintText: request.data['cat1Marks'].toString(),
              ),
            ),
            verticalSpaceSmall,
            TextFormField(
              controller: cat2MarksController,
              // initialValue: request.data['cat2Marks'].toString(),
              decoration: InputDecoration(
                labelText: 'CAT2 / ${request.data['cat2MarksOutOff']}',
                hintText: request.data['cat2Marks'].toString(),
              ),
            ),
            verticalSpaceSmall,
            verticalSpaceSmall,
            TextFormField(
              controller: examMarksController,
              // initialValue: request.data['examMarks'].toString(),
              decoration: InputDecoration(
                labelText: 'Exam / ${request.data['examMarksOutOff']}',
                hintText: request.data['examMarks'].toString(),
              ),
            ),
            verticalSpaceLarge,
            InkWell(
              onTap: () async {
                // Collect the values of the fields
                final assignMent1Marks = assignMent1MarksController.text;
                final assignMent2Marks = assignMent2MarksController.text;
                final cat1Marks = cat1MarksController.text;
                final cat2Marks = cat2MarksController.text;
                final examMarks = examMarksController.text;

                // Check if all fields are filled
                if (assignMent1Marks.isNotEmpty &&
                    assignMent2Marks.isNotEmpty &&
                    cat1Marks.isNotEmpty &&
                    cat2Marks.isNotEmpty &&
                    examMarks.isNotEmpty) {
                  try {
                    // Parse the marks to integers
                    final parsedAssignMent1Marks = int.parse(assignMent1Marks);
                    final parsedAssignMent2Marks = int.parse(assignMent2Marks);
                    final parsedCat1Marks = int.parse(cat1Marks);
                    final parsedCat2Marks = int.parse(cat2Marks);
                    final parsedExamMarks = int.parse(examMarks);

                    // Update the marks
                    await viewModel.updateMarks(
                      studentId: request.description!,
                      unitCode: request.data['unitCode'] as String,
                      data: request.data,
                      student: StudentsRegisteredUnitsModel(
                        assignMent1Marks: parsedAssignMent1Marks,
                        assignMent2Marks: parsedAssignMent2Marks,
                        cat1Marks: parsedCat1Marks,
                        cat2Marks: parsedCat2Marks,
                        examMarks: parsedExamMarks,
                      ),
                      context: context,
                    );
                    // Clear the controllers
                    if (!viewModel.isBusy) {
                      assignMent1MarksController.clear();
                      assignMent2MarksController.clear();
                      cat1MarksController.clear();
                      cat2MarksController.clear();
                      examMarksController.clear();
                    }
                  } catch (e) {
                    // Handle parsing errors
                    Fluttertoast.showToast(
                        msg:
                            'Error parsing marks. Please enter valid numbers.');
                  }
                } else {
                  // Show toast message if any field is empty
                  Fluttertoast.showToast(msg: 'Please fill all fields');
                }
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    viewModel.isBusy
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 1,
                          )
                        : const Text(
                            "Save Marks",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
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
