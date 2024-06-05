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
                          return Card(
                            child: ListTile(
                              title: Text(student.studentName!),
                              subtitle: Text(student.studentEmail!),
                              trailing: IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {},
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
