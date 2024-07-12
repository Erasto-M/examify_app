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
        appBar: AppBar(
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
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              Expanded(
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
  ) =>
      AcademicsViewModel();
}
