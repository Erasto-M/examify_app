import 'package:examify/models/student_registered_units.dart';
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
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 50),
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
              const Text(
                'Enter Student Marks',
                style: const TextStyle(
                    color: primaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w900),
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
              verticalSpaceSmall,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                  ),
                  child: DataTable(
                    columns: [
                      const DataColumn(
                        label: Text(
                          "Name",
                          style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      ),
                      DataColumn(
                        numeric: true,
                        label: Text(
                          request.description!,
                          style: const TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      ),
                    ],
                    rows: viewModel.studentsList.map((student) {
                      final controller = viewModel.controllers.putIfAbsent(
                        student.studentUid!,
                        () => TextEditingController(),
                      );
                      return DataRow(cells: [
                        DataCell(Text(student.studentName!)),
                        DataCell(
                          SizedBox(
                            width: 70,
                            child: TextFormField(
                              controller: controller,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5))),
                            ),
                          ),
                        ),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
              verticalSpaceSmall,
              Center(
                child: InkWell(
                  onTap: () {
                    debugPrint("This is the data ${request.data}");
                    viewModel.submitMarks(
                      unitCode: request.title!,
                      selectedModule: request.description!,
                      assignMent1Outof: request.data['assignment1'],
                      assignMent2Outof: request.data['assignment2'],
                      cat1Outof: request.data['cat1'],
                      cat2Outof: request.data['cat2'],
                      examOutof: request.data['exam'],
                      context: context,
                    );
                  },
                  child: Container(
                    height: 40,
                    width: MediaQuery.sizeOf(context).width / 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: primaryColor,
                    ),
                    child: Center(
                      child: viewModel.isBusy
                          ? const SpinKitSpinningLines(
                              color: Colors.white,
                              size: 30,
                            )
                          : const Text(
                              "Save Marks",
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
      ),
    );
  }

  @override
  EditStudentMarksSheetModel viewModelBuilder(BuildContext context) =>
      EditStudentMarksSheetModel();
  @override
  void onViewModelReady(EditStudentMarksSheetModel viewModel) {
    syncFormWithViewModel(viewModel);
    viewModel.fetchStudents(request.title!);
    super.onViewModelReady(viewModel);
  }
}
