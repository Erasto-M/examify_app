import 'package:examify/models/student_registered_units.dart';
import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';

import 'lecturer_my_students_viewmodel.dart';

class LecturerMyStudentsView extends StackedView<LecturerMyStudentsViewModel> {
  const LecturerMyStudentsView({Key? key, required this.unitCode});
  final String unitCode;
  final String studentUid = "j9IL4acatPcNKcOv9n0lKtstPlZ2";

  @override
  Widget builder(
    BuildContext context,
    LecturerMyStudentsViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Container(
          padding: const EdgeInsets.only(left: 10.0, right: 5.0, top: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "MyStudents",
                    style: TextStyle(
                      fontSize: 17,
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  horizontalSpaceMedium,
                  //search students
                  Expanded(
                    child: Container(
                      height: 50,
                      margin: const EdgeInsets.only(right: 10),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search students",
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: const Icon(Icons.mic),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpaceSmall,
              //list of all students
              Expanded(
                child: FutureBuilder(
                  future: viewModel.getAllMyStudents(unitCode: unitCode),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SpinKitSpinningLines(
                          color: primaryColor,
                          size: 70,
                        ),
                      );
                    } else if (!snapshot.hasData) {
                      return const Center(
                        child: Text("No students found"),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          StudentsRegisteredUnitsModel student =
                              snapshot.data![index];
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                )
                              ],
                            ),
                            margin: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(student.studentName!),
                                      const Spacer(),
                                      IconButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: primaryColor,
                                          ),
                                          onPressed: () {
                                            viewModel.openEditStudentMarksSheet(
                                                unitCode: student.unitCode!,
                                                studentId: student.studentUid!);
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ))
                                    ],
                                  ),
                                  verticalSpaceTiny,
                                  Text(student.studentEmail!)
                                ],
                              ),
                              subtitle: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                          "Assign1 : ${student.assignMent1Marks}"),
                                      const Spacer(),
                                      Text(
                                          "Assign2 : ${student.assignMent2Marks}"),
                                    ],
                                  ),
                                  verticalSpaceSmall,
                                  Row(
                                    children: [
                                      Text("cat1 marks: ${student.cat1Marks}"),
                                      const Spacer(),
                                      Text("cat2 marks: ${student.cat2Marks}"),
                                    ],
                                  ),
                                  verticalSpaceSmall,
                                  Row(
                                    children: [
                                      Text("Exam marks: ${student.examMarks}"),
                                      const Spacer(),
                                      Text(
                                          "Total marks: ${student.totalMarks}"),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  LecturerMyStudentsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LecturerMyStudentsViewModel();
}
