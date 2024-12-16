import 'package:examify/models/student_registered_units.dart';
import 'package:examify/ui/bottom_sheets/customize_units_assesment/customize_units_assesment_sheet.form.dart';
import 'package:flutter/material.dart';
import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/common/ui_helpers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'customize_units_assesment_sheet_model.dart';
@FormView(fields: [
  FormTextField(name: 'assignment1Outof'),
  FormTextField(name: 'assignment2Outof'),
  FormTextField(name: 'cat1Outof'),
  FormTextField(name: 'cat2Outof'),
  FormTextField(name: 'mainExamOutof'),
])
class CustomizeUnitsAssesmentSheet
    extends StackedView<CustomizeUnitsAssesmentSheetModel>
    with $CustomizeUnitsAssesmentSheet {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const CustomizeUnitsAssesmentSheet({
    super.key,
    required this.completer,
    required this.request,
  });

  @override
  Widget builder(
    BuildContext context,
    CustomizeUnitsAssesmentSheetModel viewModel,
    Widget? child,
  ) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        width: MediaQuery.sizeOf(context).width,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Text(
                  'Customize ',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: primaryColor),
                ),
                Flexible(
                  child: Text(
                    request.title ?? 'No Unit Name',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: primaryColor),
                  ),
                ),
              ],
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
            const Text(
              'Assesments to be Out of: ',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            verticalSpaceSmall,
            Row(
              children: [
                const Text('Assignemnt 1:'),
                const SizedBox(
                  width: 50,
                ),
                Expanded(
                    child: TextFormField(
                  controller: assignment1OutofController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.edit),
                    hintText: request.data['assignment1'].toString(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                )),
              ],
            ),
            verticalSpaceSmall,
            Row(
              children: [
                const Text('Assignemnt 2:'),
                const SizedBox(
                  width: 50,
                ),
                Expanded(
                    child: TextFormField(
                  controller: assignment2OutofController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.edit),
                    hintText: request.data['assignment2'].toString(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                )),
              ],
            ),
            verticalSpaceSmall,
            Row(
              children: [
                const Text('Cat 1:'),
                const SizedBox(
                  width: 50,
                ),
                Expanded(
                    child: TextFormField(
                  controller: cat1OutofController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.edit),
                    hintText: request.data['cat1'].toString(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                )),
              ],
            ),
            verticalSpaceSmall,
            Row(
              children: [
                const Text('Cat 2:'),
                const SizedBox(
                  width: 50,
                ),
                Expanded(
                    child: TextFormField(
                  controller: cat2OutofController,
                  decoration: InputDecoration(
                    hintText: request.data['cat2'].toString(),
                    prefixIcon: const Icon(Icons.edit),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                )),
              ],
            ),
            verticalSpaceSmall,
            Row(
              children: [
                const Text(' Main Exam:'),
                const SizedBox(
                  width: 50,
                ),
                Expanded(
                    child: TextFormField(
                  controller: mainExamOutofController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.edit),
                    hintText: request.data['exam'].toString(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                )),
              ],
            ),
            verticalSpaceMedium,
            Center(
              child: InkWell(
                onTap: () async {
                 
                  if (assignment1OutofController.text.isEmpty ||
                      assignment2OutofController.text.isEmpty ||
                      cat1OutofController.text.isEmpty ||
                      cat2OutofController.text.isEmpty ||
                      mainExamOutofController.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: 'Please fill all fields',
                        backgroundColor: Colors.red);
                    return;
                  } else if (assignment1OutofController.text
                          .contains(RegExp(r'[a-zA-Z]')) ||
                      assignment2OutofController.text
                          .contains(RegExp(r'[a-zA-Z]')) ||
                      cat1OutofController.text.contains(RegExp(r'[a-zA-Z]')) ||
                      cat2OutofController.text.contains(RegExp(r'[a-zA-Z]')) ||
                      mainExamOutofController.text
                          .contains(RegExp(r'[a-zA-Z]'))) {
                    Fluttertoast.showToast(
                        msg: 'Fields should only contain numbers',
                        backgroundColor: Colors.red);
                  }
                  await viewModel
                      .updateAssesment(
                          unitCode: request.description!.toString(),
                          units: StudentsRegisteredUnitsModel(
                            assignMent1OutOff:
                                int.parse(assignment1OutofController.text),
                            assignMent2OutOff:
                                int.parse(assignment2OutofController.text),
                            cat1Marks1OutOff:
                                int.parse(cat1OutofController.text),
                            cat2MarksOutOff:
                                int.parse(cat2OutofController.text),
                            examMarksOutOff:
                                int.parse(mainExamOutofController.text),
                          ))
                      .then((value) {
                    assignment1OutofController.clear();
                    assignment2OutofController.clear();
                    cat1OutofController.clear();
                    cat2OutofController.clear();
                    mainExamOutofController.clear();
                  }).then((value) {
                    
                  });

                  completer!(SheetResponse(confirmed: true));
                },
                child: Container(
                  width: MediaQuery.sizeOf(context).width / 2,
                  height: 50,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: viewModel.isBusy
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            'Save',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  CustomizeUnitsAssesmentSheetModel viewModelBuilder(BuildContext context) =>
      CustomizeUnitsAssesmentSheetModel();
  @override
  void onViewModelReady(CustomizeUnitsAssesmentSheetModel viewModel) {
    syncFormWithViewModel(viewModel);
    super.onViewModelReady(viewModel);
  }
}
