import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'cod_special_exams_viewmodel.dart';

class CodSpecialExamsView extends StackedView<CodSpecialExamsViewModel> {
  const CodSpecialExamsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CodSpecialExamsViewModel viewModel,
    Widget? child,
  ) {
    return DefaultTabController(
      length: viewModel.years.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              viewModel.navigateBack();
            },
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: primaryColor,
          title: const Text(
            'Manage Special Exams',
            style: TextStyle(color: Colors.white),
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.normal, color: Colors.white),
            isScrollable: true,
            tabs: viewModel.years.map((year) {
              return Tab(text: year);
            }).toList(),
            onTap: (index) {
              viewModel.setSelectedSemester(semester: viewModel.years[index]);
            },
          ),
        ),
        body: Container(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: viewModel.getAllSpecialExams(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No special exams found.'));
                }

                final specialExams = snapshot.data!;

                return ListView.builder(
                  itemCount: specialExams.length,
                  itemBuilder: (context, index) {
                    final exam = specialExams[index];
                    final List<String> unitNames =
                        List<String>.from(exam['unitName']);
                    final List<String> unitCodes =
                        List<String>.from(exam['unitCode']);
                    final List<String> statuses =
                        List<String>.from(exam['statuses']);

                    final studentUid = exam['studentId'];
                    final studentName = exam['studentName'];

                    // Ensure the lengths match
                    if (unitNames.length != unitCodes.length ||
                        unitNames.length != statuses.length) {
                      return const Card(
                        color: Colors.white,
                        child: ListTile(
                          title: Text(
                            'Error: Units and statuses list length mismatch.',
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      );
                    }

                    return Card(
                      color: Colors.white,
                      child: ListTile(
                        title: Row(
                          children: [
                            Text(
                              exam['studentRegNumber'],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                exam['studentName'],
                                style: const TextStyle(
                                    color: primaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Units Applied Special:',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            // Iterate through units and statuses
                            ...List.generate(unitNames.length, (unitIndex) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${unitIndex + 1}. ${unitCodes[unitIndex]}',
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            unitNames[unitIndex],
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        statuses[unitIndex],
                                        style: TextStyle(
                                          color: statuses[unitIndex] ==
                                                  'Lecturer Approved'
                                              ? Colors.green
                                              : statuses[unitIndex] == 'pending'
                                                  ? Colors.orange
                                                  : Colors.red,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                            verticalSpaceSmall,
                            //approve container

                            Center(
                              child: InkWell(
                                onTap: () {
                                  viewModel.updateSpecialExamStatus(
                                      studentId: studentUid,
                                      unitCodes: unitCodes);
                                },
                                child: statuses[0] == 'pending'
                                    ? Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: viewModel.isStudentLoading(
                                                studentId: studentUid)
                                            ? const CircularProgressIndicator(
                                                color: Colors.white,
                                              )
                                            : const Text(
                                                'Approve',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                ),
                                              ),
                                      )
                                    : statuses[0] == 'Lecturer Approved' ? Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: viewModel.isStudentLoading(
                                                studentId: studentUid)
                                            ? const CircularProgressIndicator(
                                                color: Colors.white,
                                              )
                                            : const Text(
                                                'Approve',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                ),
                                              ),
                                      ):
                                    const SizedBox(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            )),
      ),
    );
  }

  @override
  CodSpecialExamsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CodSpecialExamsViewModel();
}
