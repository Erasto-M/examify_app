import 'package:examify/models/student_registered_units.dart';
import 'package:flutter/material.dart';
import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/common/ui_helpers.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'students_with_special_exams_sheet_model.dart';

class StudentsWithSpecialExamsSheet
    extends StackedView<StudentsWithSpecialExamsSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const StudentsWithSpecialExamsSheet({
    super.key,
    required this.completer,
    required this.request,
  });
  @override
  Widget builder(
    BuildContext context,
    StudentsWithSpecialExamsSheetModel viewModel,
    Widget? child,
  ) {
    List<StudentsRegisteredUnitsModel> student = request.data['student'];
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
                style: TextStyle(
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
                          ("${request.description} /${request.data['exam']}"),
                          style: const TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      ),
                    ],
                    rows: student.map((student) {
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
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
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
                    viewModel.submitMarks(
                      unitCode: request.title!,
                      selectedModule: request.description!,
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
  StudentsWithSpecialExamsSheetModel viewModelBuilder(BuildContext context) =>
      StudentsWithSpecialExamsSheetModel();
}
