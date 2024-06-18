import 'package:examify/ui/bottom_sheets/edit_student_marks/edit_student_marks_sheet.form.dart';
import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import 'edit_student_marks_sheet_model.dart';

@FormView(
  fields: [
    FormTextField(name: 'assignment1'),
    FormTextField(name: 'assignment2'),
    FormTextField(name: 'cat1'),
    FormTextField(name: 'cat2'),
    FormTextField(name: 'examMarks'),
  ],
)
class EditStudentMarksSheet extends StackedView<EditStudentMarksSheetModel>
    with $EditStudentMarksSheet {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const EditStudentMarksSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    EditStudentMarksSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width,
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
            request.title ?? 'Edit Student Marks',
            style: const TextStyle(
                color: primaryColor, fontSize: 25, fontWeight: FontWeight.w900),
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
          verticalSpaceMedium,
          Form(
              child: Column(
            children: [
              TextFormField(
                controller: assignment1Controller,
                decoration: const InputDecoration(labelText: 'Assignment 1'),
              ),
              verticalSpaceTiny,
              TextFormField(
                controller: assignment2Controller,
                decoration: const InputDecoration(labelText: 'Assignment 2'),
              ),
              verticalSpaceTiny,
              TextFormField(
                controller: cat1Controller,
                decoration: const InputDecoration(labelText: 'Cat 1'),
              ),
              verticalSpaceTiny,
              TextFormField(
                controller: cat2Controller,
                decoration: const InputDecoration(labelText: 'Cat 2'),
              ),
              verticalSpaceTiny,
              TextFormField(
                controller: examMarksController,
                decoration: const InputDecoration(labelText: 'Exam Marks '),
              ),
              verticalSpaceMedium,
              viewModel.isBusy
                  ? const SpinKitSpinningLines(color: primaryColor, size: 70)
                  : InkWell(
                      onTap: () {
                        viewModel.adminUpdateStudentMarks(
                          unitcode: request.data,
                          studentUid: request.description!,
                          assignment1: assignment1Controller.text,
                          assignment2: assignment2Controller.text,
                          cat1: cat1Controller.text,
                          cat2: cat2Controller.text,
                          examMarks: examMarksController.text,
                          context: context,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        width: MediaQuery.of(context).size.width,
                        child: const Center(
                            child: Text(
                          "Submit Marks",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
                    )
            ],
          )),
        ],
      ),
    );
  }

  @override
  EditStudentMarksSheetModel viewModelBuilder(BuildContext context) =>
      EditStudentMarksSheetModel();
  @override
  void onViewModelReady(EditStudentMarksSheetModel viewModel) {
    syncFormWithViewModel(viewModel);
    super.onViewModelReady(viewModel);
  }
}
