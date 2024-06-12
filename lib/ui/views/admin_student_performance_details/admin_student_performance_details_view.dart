import 'package:examify/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../models/student_registered_units.dart';
import 'admin_student_performance_details_viewmodel.dart';

class AdminStudentPerformanceDetailsView
    extends StackedView<AdminStudentPerformanceDetailsViewModel> {
  const AdminStudentPerformanceDetailsView(
      {Key? key, required this.semesterStage, required this.studentUid})
      : super(key: key);
  final String semesterStage;
  final String studentUid;

  @override
  Widget builder(
    BuildContext context,
    AdminStudentPerformanceDetailsViewModel viewModel,
    Widget? child,
  ) {
    viewModel.fetchStudentUnits(semesterStage, studentUid);
    return Scaffold(
      appBar: AppBar(
        title: Text('Performance Details'),
      ),
      body: StreamBuilder<List<StudentsRegisteredUnitsModel>>(
        stream: viewModel.studentUnitsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No registered units found.'));
          } else {
            final units = snapshot.data!;
            return ListView.builder(
              itemCount: units.length,
              itemBuilder: (context, index) {
                final unit = units[index];
                return Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Unit Name: ${unit.unitName}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Unit Code: ${unit.unitCode}',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      verticalSpaceSmall,
                      //A row for assignment and cat marks
                      Row(
                        children: [
                          Text(
                            'Ass1: ${unit.assignMent1Marks}',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          horizontalSpaceTiny,
                          Text(
                            'Ass2: ${unit.assignMent2Marks}',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          horizontalSpaceTiny,
                          Text(
                            'Cat1: ${unit.cat1Marks}',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          horizontalSpaceTiny,
                          Text(
                            'Cat2: ${unit.cat2Marks}',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          horizontalSpaceTiny,
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Total: ${unit.totalMarks}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          horizontalSpaceMedium,
                          Text(
                            'Unit Grade: ${unit.grade}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  @override
  AdminStudentPerformanceDetailsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AdminStudentPerformanceDetailsViewModel();
  @override
  void onViewModelReady(AdminStudentPerformanceDetailsViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }
}
