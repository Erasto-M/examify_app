import 'package:examify/models/addUnit.dart';
import 'package:flutter/material.dart';
import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/common/ui_helpers.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'student_register_unit_sheet_model.dart';

class StudentRegisterUnitSheet
    extends StackedView<StudentRegisterUnitSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const StudentRegisterUnitSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StudentRegisterUnitSheetModel viewModel,
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
          Center(
            child: Column(
              children: [
                Text(
                  request.title ?? 'Register Units!!',
                  style: const TextStyle(
                      fontSize: 25,
                      color: primaryColor,
                      fontWeight: FontWeight.w900),
                ),
                verticalSpaceSmall,
                const Center(
                  child:
                      Text("Choose Atleast 5 Units  for the current semester",
                          style: TextStyle(
                            fontSize: 15,
                          )),
                ),
              ],
            ),
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
          Expanded(
              child: StreamBuilder<List<AddUnitModel>>(
            stream: viewModel.registerUnits(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SpinKitSpinningLines(
                  color: primaryColor,
                  size: 80,
                );
              } else if (snapshot.hasError) {
                return const Text('Error');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('No units available');
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final AddUnitModel unit = snapshot.data![index];
                    return Card(
                      child: ListTile(
                        title: Text(unit.unitName),
                        subtitle: Text(unit.unitCode),
                        trailing: Checkbox(
                          value: viewModel.isUnitSelected(unit.unitId!),
                          onChanged: (value) {
                            viewModel.updateUnitSelection(value!, unit);
                          },
                        ),
                      ),
                    );
                  },
                );
              }
            },
          )),
          verticalSpaceSmall,
          Center(
            child: InkWell(
              onTap: () {
                viewModel.sendUnitsToFirebase();
                completer!(SheetResponse(confirmed: true));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width / 2,
                height: 50,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: viewModel.isBusy
                      ? const SpinKitSpinningLines(
                          color: Colors.white,
                          size: 40,
                        )
                      : const Row(
                          children: [
                            Text(
                              "Add Units",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
          verticalSpaceSmall,
        ],
      ),
    );
  }

  @override
  StudentRegisterUnitSheetModel viewModelBuilder(BuildContext context) =>
      StudentRegisterUnitSheetModel();
}
