// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class StudentsRegisteredUnitsModel {
  final String? unitName;
  final String? unitCode;
  final String? unitLecturer;
  final String? unitDepartment;
  final String? semesterStage;
  final String? yearOfStudent;
  final String? studentName;
  final String? studentRegNo;
  final String? studentUid;
  final String? studentEmail;
  final String? studentPhoneNumber;
  final String? studentGender;
  final int? assignMent1Marks;
  final int? assignMent2Marks;
  final int? cat1Marks;
  final int? cat2Marks;
  final int? examMarks;
  final int? totalMarks;
  final String? grade;
  final bool? appliedSpecialExam;
  const StudentsRegisteredUnitsModel({
    this.unitName,
    this.unitCode,
    this.unitLecturer,
    this.unitDepartment,
    this.semesterStage,
    this.yearOfStudent,
    this.studentName,
    this.studentRegNo,
    this.studentUid,
    this.studentEmail,
    this.studentPhoneNumber,
    this.studentGender,
    this.assignMent1Marks,
    this.assignMent2Marks,
    this.cat1Marks,
    this.cat2Marks,
    this.examMarks,
    this.totalMarks,
    this.grade,
    this.appliedSpecialExam,
  });

  StudentsRegisteredUnitsModel copyWith({
    String? unitName,
    String? unitCode,
    String? unitLecturer,
    String? unitDepartment,
    String? semesterStage,
    String? yearOfStudent,
    String? studentName,
    String? studentRegNo,
    String? studentUid,
    String? studentEmail,
    String? studentPhoneNumber,
    String? studentGender,
    int? assignMent1Marks,
    int? assignMent2Marks,
    int? cat1Marks,
    int? cat2Marks,
    int? examMarks,
    int? totalMarks,
    String? grade,
    bool? appliedSpecialExam,
  }) {
    return StudentsRegisteredUnitsModel(
      unitName: unitName ?? this.unitName,
      unitCode: unitCode ?? this.unitCode,
      unitLecturer: unitLecturer ?? this.unitLecturer,
      unitDepartment: unitDepartment ?? this.unitDepartment,
      semesterStage: semesterStage ?? this.semesterStage,
      yearOfStudent: yearOfStudent ?? this.yearOfStudent,
      studentName: studentName ?? this.studentName,
      studentRegNo: studentRegNo ?? this.studentRegNo,
      studentUid: studentUid ?? this.studentUid,
      studentEmail: studentEmail ?? this.studentEmail,
      studentPhoneNumber: studentPhoneNumber ?? this.studentPhoneNumber,
      studentGender: studentGender ?? this.studentGender,
      assignMent1Marks: assignMent1Marks ?? this.assignMent1Marks,
      assignMent2Marks: assignMent2Marks ?? this.assignMent2Marks,
      cat1Marks: cat1Marks ?? this.cat1Marks,
      cat2Marks: cat2Marks ?? this.cat2Marks,
      examMarks: examMarks ?? this.examMarks,
      totalMarks: totalMarks ?? this.totalMarks,
      grade: grade ?? this.grade,
      appliedSpecialExam: appliedSpecialExam ?? this.appliedSpecialExam,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'unitName': unitName ?? '',
      'unitCode': unitCode ?? '',
      'unitLecturer': unitLecturer ?? '',
      'unitDepartment': unitDepartment ?? "Computer Science",
      'semesterStage': semesterStage ?? "",
      'yearOfStudent': yearOfStudent ?? "",
      'studentName': studentName ?? '',
      'studentRegNo': studentRegNo ?? '',
      'studentUid': studentUid ?? '',
      'studentEmail': studentEmail ?? '',
      'studentPhoneNumber': studentPhoneNumber ?? '',
      'studentGender': studentGender ?? '',
      'assignMent1Marks': assignMent1Marks ?? 0,
      'assignMent2Marks': assignMent2Marks ?? 0,
      'cat1Marks': cat1Marks ?? 0,
      'cat2Marks': cat2Marks ?? 0,
      'examMarks': examMarks ?? 0,
      'totalMarks': totalMarks ?? 0,
      'grade': grade ?? '',
      'appliedSpecialExam': appliedSpecialExam ?? false,
    };
  }

  factory StudentsRegisteredUnitsModel.fromMap(Map<String, dynamic> map) {
    return StudentsRegisteredUnitsModel(
      unitName:
          map['unitName'] != null ? map["unitName"] ?? '' as String : null,
      unitCode:
          map['unitCode'] != null ? map["unitCode"] ?? '' as String : null,
      unitLecturer: map['unitLecturer'] != null
          ? map["unitLecturer"] ?? '' as String
          : null,
      unitDepartment: map['unitDepartment'] != null
          ? map["unitDepartment"] ?? '' as String
          : null,
      semesterStage: map['semesterStage'] != null
          ? map["semesterStage"] ?? '' as String
          : null,
      yearOfStudent: map['yearOfStudent'] != null
          ? map["yearOfStudent"] ?? '' as String
          : null,
      studentName: map['studentName'] != null
          ? map["studentName"] ?? '' as String
          : null,
      studentRegNo: map['studentRegNo'] != null
          ? map["studentRegNo"] ?? '' as String
          : null,
      studentUid:
          map['studentUid'] != null ? map["studentUid"] ?? '' as String : null,
      studentEmail: map['studentEmail'] != null
          ? map["studentEmail"] ?? '' as String
          : null,
      studentPhoneNumber: map['studentPhoneNumber'] != null
          ? map["studentPhoneNumber"] ?? '' as String
          : null,
      studentGender: map['studentGender'] != null
          ? map["studentGender"] ?? '' as String
          : null,
      assignMent1Marks: map['assignMent1Marks'] != null
          ? map["assignMent1Marks"] ?? 0 as int
          : null,
      assignMent2Marks: map['assignMent2Marks'] != null
          ? map["assignMent2Marks"] ?? 0 as int
          : null,
      cat1Marks: map['cat1Marks'] != null ? map["cat1Marks"] ?? 0 as int : null,
      cat2Marks: map['cat2Marks'] != null ? map["cat2Marks"] ?? 0 as int : null,
      examMarks: map['examMarks'] != null ? map["examMarks"] ?? 0 as int : null,
      totalMarks:
          map['totalMarks'] != null ? map["totalMarks"] ?? 0 as int : null,
      grade: map['grade'] != null ? map["grade"] ?? '' as String : null,
      appliedSpecialExam: map['appliedSpecialExam'] != null
          ? map["appliedSpecialExam"] ?? false as bool
          : null,
    );
  }
  factory StudentsRegisteredUnitsModel.fromDocument(DocumentSnapshot doc) {
    return StudentsRegisteredUnitsModel(
      unitName: doc['unitName'],
      unitCode: doc['unitCode'],
      unitLecturer: doc['unitLecturer'],
      unitDepartment: doc['unitDepartment'],
      semesterStage: doc['semesterStage'],
      yearOfStudent: doc['yearOfStudent'],
      studentName: doc['studentName'],
      studentRegNo: doc['studentRegNo'],
      studentUid: doc['studentUid'],
      studentEmail: doc['studentEmail'],
      studentPhoneNumber: doc['studentPhoneNumber'],
      studentGender: doc['studentGender'],
      assignMent1Marks: doc['assignMent1Marks'],
      assignMent2Marks: doc['assignMent2Marks'],
      cat1Marks: doc['cat1Marks'],
      cat2Marks: doc['cat2Marks'],
      examMarks: doc['examMarks'],
      totalMarks: doc['totalMarks'],
      grade: doc['grade'],
      appliedSpecialExam: doc['appliedSpecialExam'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentsRegisteredUnitsModel.fromJson(String source) =>
      StudentsRegisteredUnitsModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StudentsRegisteredUnitsModel( unitName: $unitName, unitCode: $unitCode, unitLecturer: $unitLecturer, unitDepartment: $unitDepartment, semesterStage: $semesterStage, yearOfStudent: $yearOfStudent, studentName: $studentName, studentRegNo: $studentRegNo, studentUid: $studentUid, studentEmail: $studentEmail, studentPhoneNumber: $studentPhoneNumber, studentGender: $studentGender, assignMent1Marks: $assignMent1Marks, assignMent2Marks: $assignMent2Marks, cat1Marks: $cat1Marks, cat2Marks: $cat2Marks, examMarks: $examMarks, totalMarks: $totalMarks, grade: $grade, appliedSpecialExam: $appliedSpecialExam)';
  }

  @override
  bool operator ==(covariant StudentsRegisteredUnitsModel other) {
    if (identical(this, other)) return true;

    return other.unitName == unitName &&
        other.unitCode == unitCode &&
        other.unitLecturer == unitLecturer &&
        other.unitDepartment == unitDepartment &&
        other.semesterStage == semesterStage &&
        other.yearOfStudent == yearOfStudent &&
        other.studentName == studentName &&
        other.studentRegNo == studentRegNo &&
        other.studentUid == studentUid &&
        other.studentEmail == studentEmail &&
        other.studentPhoneNumber == studentPhoneNumber &&
        other.studentGender == studentGender &&
        other.assignMent1Marks == assignMent1Marks &&
        other.assignMent2Marks == assignMent2Marks &&
        other.cat1Marks == cat1Marks &&
        other.cat2Marks == cat2Marks &&
        other.examMarks == examMarks &&
        other.totalMarks == totalMarks &&
        other.grade == grade &&
        other.appliedSpecialExam == appliedSpecialExam;
  }

  @override
  int get hashCode {
    return unitName.hashCode ^
        unitCode.hashCode ^
        unitLecturer.hashCode ^
        unitDepartment.hashCode ^
        semesterStage.hashCode ^
        yearOfStudent.hashCode ^
        studentName.hashCode ^
        studentRegNo.hashCode ^
        studentUid.hashCode ^
        studentEmail.hashCode ^
        studentPhoneNumber.hashCode ^
        studentGender.hashCode ^
        assignMent1Marks.hashCode ^
        assignMent2Marks.hashCode ^
        cat1Marks.hashCode ^
        cat2Marks.hashCode ^
        examMarks.hashCode ^
        totalMarks.hashCode ^
        grade.hashCode ^
        appliedSpecialExam.hashCode;
  }
}
