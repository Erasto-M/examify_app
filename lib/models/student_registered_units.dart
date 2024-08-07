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
  final int? assignMent1OutOff;
  final int? assignMent2OutOff;
  final int? cat1Marks1OutOff;
  final int? cat2MarksOutOff;
  final int? examMarksOutOff;
  final int? cat1Marks;
  final int? cat2Marks;
  final int? examMarks;
  final int? totalMarks;
  final String? grade;
  final String? recommendation;
  final bool? appliedSpecialExam;
  final double? meanMarks;
  final String? meanGrade;
  String? missingMarksMessage;
  final bool? isUnitApproved;
  final String? cohort;
  StudentsRegisteredUnitsModel({
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
    this.assignMent1OutOff,
    this.assignMent2OutOff,
    this.cat1Marks1OutOff,
    this.cat2MarksOutOff,
    this.examMarksOutOff,
    this.cat1Marks,
    this.cat2Marks,
    this.examMarks,
    this.totalMarks,
    this.grade,
    this.recommendation,
    this.appliedSpecialExam,
    this.meanMarks,
    this.meanGrade,
    this.missingMarksMessage = '',
    this.isUnitApproved,
    this.cohort,
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
    int? assignMent1OutOff,
    int? assignMent2OutOff,
    int? cat1Marks1OutOff,
    int? cat2MarksOutOff,
    int? examMarksOutOff,
    int? cat1Marks,
    int? cat2Marks,
    int? examMarks,
    int? totalMarks,
    String? grade,
    String? recommendation,
    bool? appliedSpecialExam,
    double? meanMarks,
    String? meanGrade,
    String? missingMarksMessage,
    bool? isUnitApproved,
    String? cohort,
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
      assignMent1OutOff: assignMent1OutOff ?? this.assignMent1OutOff,
      assignMent2OutOff: assignMent2OutOff ?? this.assignMent2OutOff,
      cat1Marks1OutOff: cat1Marks1OutOff ?? this.cat1Marks1OutOff,
      cat2MarksOutOff: cat2MarksOutOff ?? this.cat2MarksOutOff,
      examMarksOutOff: examMarksOutOff ?? this.examMarksOutOff,
      cat1Marks: cat1Marks ?? this.cat1Marks,
      cat2Marks: cat2Marks ?? this.cat2Marks,
      examMarks: examMarks ?? this.examMarks,
      totalMarks: totalMarks ?? this.totalMarks,
      grade: grade ?? this.grade,
      recommendation: recommendation ?? this.recommendation,
      appliedSpecialExam: appliedSpecialExam ?? this.appliedSpecialExam,
      meanMarks: meanMarks ?? this.meanMarks,
      meanGrade: meanGrade ?? this.meanGrade,
      missingMarksMessage: missingMarksMessage ?? this.missingMarksMessage,
      isUnitApproved: isUnitApproved ?? this.isUnitApproved,
      cohort: cohort ?? this.cohort,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'unitName': unitName,
      'unitCode': unitCode,
      'unitLecturer': unitLecturer,
      'unitDepartment': unitDepartment,
      'semesterStage': semesterStage,
      'yearOfStudent': yearOfStudent,
      'studentName': studentName,
      'studentRegNo': studentRegNo,
      'studentUid': studentUid,
      'studentEmail': studentEmail,
      'studentPhoneNumber': studentPhoneNumber,
      'studentGender': studentGender,
      'assignMent1Marks': assignMent1Marks,
      'assignMent2Marks': assignMent2Marks,
      'assignMent1OutOff': assignMent1OutOff,
      'assignMent2OutOff': assignMent2OutOff,
      'cat1Marks1OutOff': cat1Marks1OutOff,
      'cat2MarksOutOff': cat2MarksOutOff,
      'examMarksOutOff': examMarksOutOff,
      'cat1Marks': cat1Marks,
      'cat2Marks': cat2Marks,
      'examMarks': examMarks,
      'totalMarks': totalMarks,
      'grade': grade,
      'recommendation': recommendation,
      'appliedSpecialExam': appliedSpecialExam,
      'meanMarks': meanMarks,
      'meanGrade': meanGrade,
      'missingMarksMessage': missingMarksMessage,
      'isUnitApproved': isUnitApproved,
      'cohort': cohort,
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
      assignMent1OutOff: map['assignMent1OutOff'] != null
          ? map["assignMent1OutOff"] ?? 0 as int
          : null,
      assignMent2OutOff: map['assignMent2OutOff'] != null
          ? map["assignMent2OutOff"] ?? 0 as int
          : null,
      cat1Marks1OutOff: map['cat1Marks1OutOff'] != null
          ? map["cat1Marks1OutOff"] ?? 0 as int
          : null,
      cat2MarksOutOff: map['cat2MarksOutOff'] != null
          ? map["cat2MarksOutOff"] ?? 0 as int
          : null,
      examMarksOutOff: map['examMarksOutOff'] != null
          ? map["examMarksOutOff"] ?? 0 as int
          : null,
      cat1Marks: map['cat1Marks'] != null ? map["cat1Marks"] ?? 0 as int : null,
      cat2Marks: map['cat2Marks'] != null ? map["cat2Marks"] ?? 0 as int : null,
      examMarks: map['examMarks'] != null ? map["examMarks"] ?? 0 as int : null,
      totalMarks:
          map['totalMarks'] != null ? map["totalMarks"] ?? 0 as int : null,
      grade: map['grade'] != null ? map["grade"] ?? '' as String : null,
      recommendation: map['recommendation'] != null
          ? map["recommendation"] ?? '' as String
          : null,
      appliedSpecialExam: map['appliedSpecialExam'] != null
          ? map["appliedSpecialExam"] ?? false as bool
          : null,
      meanMarks:
          map['meanMarks'] != null ? map["meanMarks"] ?? 0.0 as double : null,
      meanGrade:
          map['meanGrade'] != null ? map["meanGrade"] ?? '' as String : null,
      missingMarksMessage: map['missingMarksMessage'] != null
          ? map["missingMarksMessage"] ?? '' as String
          : null,
      isUnitApproved: map['isUnitApproved'] != null
          ? map["isUnitApproved"] ?? false as bool
          : null,
      cohort: map['cohort'] != null ? map["cohort"] ?? '' as String : null,
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
    return 'StudentsRegisteredUnitsModel(unitName: $unitName, unitCode: $unitCode, unitLecturer: $unitLecturer, unitDepartment: $unitDepartment, semesterStage: $semesterStage, yearOfStudent: $yearOfStudent, studentName: $studentName, studentRegNo: $studentRegNo, studentUid: $studentUid, studentEmail: $studentEmail, studentPhoneNumber: $studentPhoneNumber, studentGender: $studentGender, assignMent1Marks: $assignMent1Marks, assignMent2Marks: $assignMent2Marks, assignMent1OutOff: $assignMent1OutOff, assignMent2OutOff: $assignMent2OutOff, cat1Marks1OutOff: $cat1Marks1OutOff, cat2MarksOutOff: $cat2MarksOutOff, examMarksOutOff: $examMarksOutOff, cat1Marks: $cat1Marks, cat2Marks: $cat2Marks, examMarks: $examMarks, totalMarks: $totalMarks, grade: $grade, recommendation: $recommendation, appliedSpecialExam: $appliedSpecialExam, meanMarks: $meanMarks, meanGrade: $meanGrade, missingMarksMessage: $missingMarksMessage, isUnitApproved: $isUnitApproved, cohort: $cohort)';
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
        other.assignMent1OutOff == assignMent1OutOff &&
        other.assignMent2OutOff == assignMent2OutOff &&
        other.cat1Marks1OutOff == cat1Marks1OutOff &&
        other.cat2MarksOutOff == cat2MarksOutOff &&
        other.examMarksOutOff == examMarksOutOff &&
        other.cat1Marks == cat1Marks &&
        other.cat2Marks == cat2Marks &&
        other.examMarks == examMarks &&
        other.totalMarks == totalMarks &&
        other.grade == grade &&
        other.recommendation == recommendation &&
        other.appliedSpecialExam == appliedSpecialExam &&
        other.meanMarks == meanMarks &&
        other.meanGrade == meanGrade &&
        other.missingMarksMessage == missingMarksMessage &&
        other.isUnitApproved == isUnitApproved &&
        other.cohort == cohort;
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
        assignMent1OutOff.hashCode ^
        assignMent2OutOff.hashCode ^
        cat1Marks1OutOff.hashCode ^
        cat2MarksOutOff.hashCode ^
        examMarksOutOff.hashCode ^
        cat1Marks.hashCode ^
        cat2Marks.hashCode ^
        examMarks.hashCode ^
        totalMarks.hashCode ^
        grade.hashCode ^
        recommendation.hashCode ^
        appliedSpecialExam.hashCode ^
        meanMarks.hashCode ^
        meanGrade.hashCode ^
        missingMarksMessage.hashCode ^
        isUnitApproved.hashCode ^
        cohort.hashCode;
  }
}
