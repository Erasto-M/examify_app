import 'package:examify/models/addUnit.dart';
import 'package:examify/ui/bottom_sheets/add_unit/add_unit_sheet.form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/common/ui_helpers.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import 'add_unit_sheet_model.dart';

@FormView(
    fields: [FormTextField(name: "UnitName"), FormTextField(name: "UnitCode")])
class AddUnitSheet extends StackedView<AddUnitSheetModel> with $AddUnitSheet {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const AddUnitSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AddUnitSheetModel viewModel,
    Widget? child,
  ) {
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
          Center(
            child: Row(
              children: [
                Text(
                  request.title ?? 'Add Unit - ',
                  style: const TextStyle(
                      fontSize: 25,
                      color: primaryColor,
                      fontWeight: FontWeight.w900),
                ),
                if (request.description != null) ...[
                  verticalSpaceTiny,
                  Text(
                    request.description!,
                    style: const TextStyle(
                        fontSize: 25,
                        color: primaryColor,
                        fontWeight: FontWeight.w900),
                    softWrap: true,
                  ),
                ],
              ],
            ),
          ),
          verticalSpaceMedium,
          TextFormField(
            controller: unitNameController,
            decoration: InputDecoration(
              labelText: 'Unit Name',
              hintText: 'Enter the unit name',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          verticalSpaceTiny,
          TextFormField(
            controller: unitCodeController,
            decoration: InputDecoration(
              labelText: 'Unit Code',
              hintText: 'Enter the unit code',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          verticalSpaceMedium,
          Text(
            'Choose respective lecturer',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          verticalSpaceTiny,
          // dropdown to show lecturers list with a given list from viewmodel
          DropdownButtonFormField(
            items: viewModel.lecturers
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ),
                )
                .toList(),
            onChanged: (value) {
              viewModel.setSelectedLecturer(value);
            },
            decoration: const InputDecoration(
              hintText: 'Select lecturer',
            ),
          ),

          Text(
            'Choose semester stage',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          verticalSpaceTiny,
          // dropdown to show semester stages list with a given list from viewmodel
          DropdownButtonFormField(
            items: viewModel.semesterStages
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ),
                )
                .toList(),
            onChanged: (value) {
              viewModel.setSelectedSemesterStage(value);
            },
            decoration: const InputDecoration(
              hintText: 'Select semester stage',
            ),
          ),
          verticalSpaceMedium,
          viewModel.isBusy
              ? const SpinKitSpinningLines(
                  color: primaryColor,
                  size: 80,
                )
              : InkWell(
                  onTap: () {
                    final units = AddUnitModel(
                        unitName: unitNameController.text,
                        unitCode: unitCodeController.text,
                        unitLecturerName: viewModel.getSelectedLec,
                        semesterStage:
                            "${request.description}${viewModel.getSelectedSemester}",
                        year: "${request.description}");

                    viewModel.addUnit(addUnitModel: units);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                        child: Text(
                      'Add Unit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ),
                ),
          verticalSpaceMedium,
        ],
      ),
    );
  }

  @override
  AddUnitSheetModel viewModelBuilder(BuildContext context) =>
      AddUnitSheetModel();

  @override
  void onViewModelReady(AddUnitSheetModel viewModel) {
    syncFormWithViewModel(viewModel);
  }
}
