import 'package:flutter/material.dart';
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
          title: const Text('Academic Reports'),
          bottom: TabBar(
            indicatorColor: Theme.of(context).primaryColor,
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.black,
            tabs: const [
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
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButton<String>(
                value: viewModel.selectedSemester,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    viewModel.setSelectedSemester(newValue);
                  }
                },
                items: viewModel.semesters
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: TabBarView(
                  children: [
                    AcademicReportList(viewModel: viewModel),
                    AcademicReportList(viewModel: viewModel),
                    AcademicReportList(viewModel: viewModel),
                    AcademicReportList(viewModel: viewModel),
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

class AcademicReportList extends StatelessWidget {
  final AcademicsViewModel viewModel;

  const AcademicReportList({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: viewModel.academicReports.length,
      itemBuilder: (context, index) {
        final report = viewModel.academicReports[index];
        return ListTile(
          leading: Text('${index + 1}'),
          title: Text(report['RegNo']!),
          subtitle: Text(report['Name']!),
        );
      },
    );
  }
}
