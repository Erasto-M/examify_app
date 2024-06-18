import 'package:examify/ui/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../models/student_registered_units.dart';
import 'admin_student_performance_details_viewmodel.dart';

class AdminStudentPerformanceDetailsView extends StatefulWidget {
  const AdminStudentPerformanceDetailsView({
    Key? key,
    required this.semesterStage,
    required this.studentUid,
  }) : super(key: key);

  final String semesterStage;
  final String studentUid;

  @override
  _AdminStudentPerformanceDetailsViewState createState() =>
      _AdminStudentPerformanceDetailsViewState();
}

class _AdminStudentPerformanceDetailsViewState
    extends State<AdminStudentPerformanceDetailsView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AdminStudentPerformanceDetailsViewModel>.reactive(
      viewModelBuilder: () => AdminStudentPerformanceDetailsViewModel(),
      onModelReady: (viewModel) =>
          viewModel.fetchStudentUnitsAndGenerateRecommendations(
              widget.semesterStage, widget.studentUid),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Performance Details'),
        ),
        body: Column(
          children: [
            const SizedBox(height: 10), // Add some space between the items
            Expanded(
              child: StreamBuilder<List<StudentsRegisteredUnitsModel>>(
                stream: viewModel.studentUnitsStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('No registered units found.'));
                  } else {
                    final units = snapshot.data!;
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'Marks Recommendations',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                viewModel.recommendationText ?? '',
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 10),

                        Expanded(
                          child: ListView.builder(
                            itemCount: units.length,
                            itemBuilder: (context, index) {
                              final unit = units[index];
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 10.0),
                                padding: const EdgeInsets.all(15.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black12),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                        Text(
                                          'Unit Name: ${unit.unitName}',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Unit Code: ${unit.unitCode}',
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Divider(color: Colors.black12),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Ass1: ${unit.assignMent1Marks}',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Text(
                                          'Ass2: ${unit.assignMent2Marks}',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Cat1: ${unit.cat1Marks}',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Text(
                                          'Cat2: ${unit.cat2Marks}',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Text(
                                          'Exam: ${unit.examMarks}',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    const Divider(color: Colors.black12),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Total: ${unit.totalMarks}',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Unit Grade: ${unit.grade}',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.edit),
                                          onPressed: () {
                                            viewModel.editUnitMarks(
                                                unitCode: unit.unitCode!,
                                                studentId: unit.studentUid!);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
