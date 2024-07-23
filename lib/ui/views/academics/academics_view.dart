import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examify/ui/common/app_colors.dart';
import 'package:examify/ui/views/missing_marks/missing_marks_view.dart';
import 'package:examify/ui/views/passlist/passlist_view.dart';
import 'package:examify/ui/views/special_exams_list/special_exams_list_view.dart';
import 'package:examify/ui/views/supplist/supplist_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

import 'academics_viewmodel.dart';

class AcademicsView extends StackedView<AcademicsViewModel> {
  const AcademicsView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context,
      AcademicsViewModel viewModel,
      Widget? child,
      ) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: primaryColor,
          title: const Text(
            'Academic Reports',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: DropdownButton<String>(
                value: viewModel.getselectedSemester,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    viewModel.setSelectedSemester(newValue);
                  }
                },
                style: const TextStyle(color: Colors.white),
                dropdownColor: primaryColor,
                icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                items: viewModel.semesters
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            labelStyle: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(color: Colors.white, fontSize: 15),
            tabs: [
              Tab(text: 'Passlist'),
              Tab(text: 'Supp'),
              Tab(text: 'Special'),
              Tab(text: 'Missing Marks'),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              StreamBuilder<DocumentSnapshot?>(
                stream: viewModel.getReportsAvailabilityStatus(viewModel.getselectedSemester),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return const Text('Error fetching data');
                  }
                  bool isAvailable = snapshot.data?['${viewModel.getselectedSemester}_available'] ?? false;
                  if (!isAvailable) {
                    return const Text('Reports not yet available');
                  }
                  return Expanded(
                    child: TabBarView(
                      children: [
                        PasslistView(
                          selectedSemesterStage: viewModel.getselectedSemester,
                        ),
                        SupplistView(
                          semesterStage: viewModel.getselectedSemester,
                        ),
                        SpecialExamsListView(
                          semesterStage: viewModel.getselectedSemester,
                        ),
                        MissingMarksView(
                          semesterStage: viewModel.getselectedSemester,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  AcademicsViewModel viewModelBuilder(
      BuildContext context,
      ) => AcademicsViewModel();
}
