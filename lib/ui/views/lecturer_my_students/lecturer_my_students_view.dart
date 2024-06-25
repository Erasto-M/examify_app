import 'dart:io';

import 'package:examify/models/student_registered_units.dart';
import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:stacked/stacked.dart';

import 'lecturer_my_students_viewmodel.dart';

class LecturerMyStudentsView extends StackedView<LecturerMyStudentsViewModel> {
  const LecturerMyStudentsView({
    Key? key,
    required this.unitCode,
    required this.unitName,
  });
  final String unitCode;
  final String unitName;

  @override
  Widget builder(
    BuildContext context,
    LecturerMyStudentsViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Container(
          padding: const EdgeInsets.only(left: 10.0, right: 5.0, top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        viewModel.backToHome();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: primaryColor,
                      )),
                  Text(
                    unitName,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              verticalSpaceSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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
              Container(
                width: MediaQuery.sizeOf(context).width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Select",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ]),
                            child: DropdownButton(
                              value: viewModel.selectedExamModuleToEnterMarks,
                              items: viewModel.examModelues
                                  .map((String examModule) => DropdownMenuItem(
                                        value: examModule,
                                        child: Text(examModule),
                                      ))
                                  .toList(),
                              onChanged: (newValue) {
                                viewModel.setSelectedExamModuleToEnterMarks(
                                    newValue.toString());
                              },
                            ))
                      ],
                    ),
                    verticalSpaceSmall,
                    Center(
                      child: InkWell(
                        onTap: () {
                          viewModel.openEditStudentMarksSheet(
                            unitCode: unitCode,
                            unitName: unitName,
                          );
                        },
                        child: Container(
                          height: 40,
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                            child: Text(
                              "Click here to enter marks",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              verticalSpaceSmall,
              const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              const Text(
                "Marks Sheet ",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                ),
              ),

              verticalSpaceSmall,
              //list of all students

              Expanded(
                child: StreamBuilder<List<StudentsRegisteredUnitsModel>>(
                  stream: viewModel.getAllMyStudents(unitCode: unitCode),
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
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: MediaQuery.of(context).size.width,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DataTable(
                                columns: const [
                                  DataColumn(
                                    label: Text(
                                      "Name",
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "RegNo",
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Assignment 1",
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Assignment 2",
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Cat 1",
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "cat 2",
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Exam ",
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Total marks",
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Grade",
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Action",
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    ),
                                  ),
                                ],
                                rows: snapshot.data!.map((student) {
                                  return DataRow(cells: [
                                    DataCell(
                                      Text(student.studentName!),
                                    ),
                                    DataCell(
                                      Text(student.studentPhoneNumber!),
                                    ),
                                    DataCell(
                                      Text(
                                        student.assignMent1Marks.toString(),
                                      ),
                                    ),
                                    DataCell(
                                      Text(student.assignMent2Marks.toString()),
                                    ),
                                    DataCell(
                                      Text(student.cat1Marks.toString()),
                                    ),
                                    DataCell(
                                      Text(
                                        student.cat2Marks.toString(),
                                      ),
                                    ),
                                    DataCell(
                                      Text(student.examMarks.toString()),
                                    ),
                                    DataCell(
                                      Text(student.totalMarks.toString()),
                                    ),
                                    DataCell(
                                      Text(student.grade.toString()),
                                    ),
                                    DataCell(
                                      MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: Tooltip(
                                          message:
                                              "Edit marks for ${student.studentName}",
                                          child: IconButton(
                                            onPressed: () {
                                              // Add your edit functionality here
                                              viewModel
                                                  .showEditMarksPerStudentSheet(
                                                studentName:
                                                    student.studentName!,
                                                studentUid: student.studentUid!,
                                                assignMent1Marks:
                                                    student.assignMent1Marks!,
                                                assignMent2Marks:
                                                    student.assignMent2Marks!,
                                                cat1Marks: student.cat1Marks!,
                                                cat2Marks: student.cat2Marks!,
                                                examMarks: student.examMarks!,
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.edit,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]);
                                }).toList(),
                              ),
                              // download pdf
                              verticalSpaceMedium,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Center(
                                    child: InkWell(
                                      onTap: () async {
                                        final pdf = await viewModel.generatePDF(
                                            snapshot.data!, unitName);
                                        final output =
                                            await getTemporaryDirectory();
                                        final file =
                                            File('${output.path}/marks.pdf');
                                        await file
                                            .writeAsBytes(await pdf.save());
                                        viewModel.setPdfPath(file.path);
                                      },
                                      child: Container(
                                        height: 40,
                                        width:
                                            MediaQuery.sizeOf(context).width /
                                                2,
                                        decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Center(
                                          child: Text(
                                            "View Marks PDF",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  horizontalSpaceMedium,
                                  Center(
                                    child: InkWell(
                                      child: Container(
                                        height: 40,
                                        width:
                                            MediaQuery.sizeOf(context).width /
                                                2,
                                        decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Center(
                                          child: Text(
                                            "Download Marks PDF",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              verticalSpaceMedium,
                            ],
                          ),
                        ),
                      );
                      //
                    }
                  },
                ),
              ),
              verticalSpaceSmall,
              viewModel.pdfPath != null
                  ? Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 30),
                        height: 500,
                        child: PDFView(
                          filePath: viewModel.pdfPath,
                          enableSwipe: true,
                          swipeHorizontal: true,
                          autoSpacing: false,
                          pageFling: false,
                          onRender: (pages) {
                            viewModel.setPageCount(pages!);
                          },
                          onViewCreated: (controller) {
                            viewModel.setPdfController(controller);
                          },
                          onPageChanged: (page, total) {
                            viewModel.setCurrentPage(page!);
                          },
                          onError: (error) {
                            print(error.toString());
                          },
                          onPageError: (page, error) {
                            print('$page : ${error.toString()}');
                          },
                        ),
                      ),
                    )
                  : Container()
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


//erasto flutter developer
