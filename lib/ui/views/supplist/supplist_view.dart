import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../../../models/student_registered_units.dart';
import '../../common/app_colors.dart';
import 'supplist_viewmodel.dart';

@FormView(
  fields: [
    FormTextField(name: 'searchSupplist'),
  ],
)
class SupplistView extends StackedView<SupplistViewModel> {
  const SupplistView({Key? key, required this.semesterStage}) : super(key: key);
  final String semesterStage;
  @override
  Widget builder(
    BuildContext context,
    SupplistViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
          child:
              StreamBuilder<Map<String, List<StudentsRegisteredUnitsModel>>>(
            stream: viewModel.getSuppList(semesterStage: semesterStage),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SpinKitSpinningLines(
                    color: primaryColor,
                    size: 70,
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (!snapshot.hasData) {
                return const Center(
                  child: Text("No students found"),
                );
              } else {
                final studentsMap = snapshot.data!;
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: studentsMap.length,
                      itemBuilder: (context, index) {
                        final studentUid = studentsMap.keys.elementAt(index);
                        final studentUnits = studentsMap[studentUid]!;
                        final student = studentUnits.first;
                        return Card(
                          color: Colors.white,
                          child: ListTile(
                            title: Text(student.studentName!,
                                style: const TextStyle(
                                    color: primaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(student.studentRegNo!),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Center(
                                    child: Text(
                                  'Supplementary Units:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                                const SizedBox(
                                  height: 5,
                                ),
                                ...studentUnits
                                    .asMap()
                                    .entries
                                    .map((unit) => Text(
                                        '${unit.key + 1}. ${unit.value.unitCode}: ${unit.value.unitName}'))
                                    .toList(),
                              ],
                            ),
                          ),
                        );
                      }),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  SupplistViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SupplistViewModel();
}
