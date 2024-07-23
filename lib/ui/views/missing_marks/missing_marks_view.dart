import 'package:examify/ui/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';

import '../../../models/student_registered_units.dart';
import 'missing_marks_viewmodel.dart';

class MissingMarksView extends StackedView<MissingMarksViewModel> {
  const MissingMarksView({Key? key, required this.semesterStage})
      : super(key: key);
  final String semesterStage;

  @override
  Widget builder(
    BuildContext context,
    MissingMarksViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child:
                StreamBuilder<Map<String, List<StudentsRegisteredUnitsModel>>>(
              stream:
                  viewModel.getMissingMarksList(semesterStage: semesterStage),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("No students found with missing marks"),
                  );
                } else {
                  final Map<String, List<StudentsRegisteredUnitsModel>>
                      studentsMap = snapshot.data!;
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
                            title: Text(
                              student.studentName ?? '',
                              style: const TextStyle(
                                color: primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(student.studentRegNo ??
                                    'Registration No. not provided'),
                                const SizedBox(height: 10),
                                const Text(
                                  'Missing Marks Details:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                ...studentUnits.map((unit) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Unit: ${unit.unitName} (${unit.unitCode})',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      if (unit.assignMent1Marks == null ||
                                          unit.assignMent2Marks == null)
                                        Text(
                                            'Missing Assignments: ${unit.assignMent1Marks == null ? "Assignment 1, " : ""}${unit.assignMent2Marks == null ? "Assignment 2" : ""}'),
                                      if (unit.cat1Marks == null ||
                                          unit.cat2Marks == null)
                                        Text(
                                            'Missing CATs: ${unit.cat1Marks == null ? "CAT 1, " : ""}${unit.cat2Marks == null ? "CAT 2" : ""}'),
                                      if (unit.examMarks == null ||
                                          unit.totalMarks == null)
                                        Text(
                                            'Missing Exams: ${unit.examMarks == null ? "Exam Marks " : ""}'),
                                    ],
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ));
  }

  @override
  MissingMarksViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MissingMarksViewModel();
}
