import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examify/app/app.locator.dart';
import 'package:examify/app/app.router.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AcademicsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  String _selectedSemester = 'Y1S1';
  final List<String> _semesters = [
    'Y1S1',
    'Y1S2',
    'Y2S1',
    'Y2S2',
    'Y3S1',
    'Y3S2',
    'Y4S1',
    'Y4S2'
  ];

  Stream<DocumentSnapshot?> getReportsAvailabilityStatus(String selectedSemester) {
    return FirebaseFirestore.instance
        .collection('academic_reports_availability')
        .doc('1YqKYQDE7I7cJGNQEzE8')
        .snapshots();
  }


  String get getselectedSemester => _selectedSemester;
  List<String> get semesters => _semesters;
 

  void setSelectedSemester(String semester) {
    _selectedSemester = semester;
    notifyListeners();
  }
}

