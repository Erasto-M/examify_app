// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SpecialExamsModel {
  final String? studentName;
  final String? studeRegNo;
  final String? studeEmail;
  final String? studePhone;
  final String? studeUid;
  final String? unitCode;
  final String? unitName;
  final String? unitLecturer;
  final String? semesterStage;
  final String? yearOfStudent;
  final String? specialExamStatus;
  final String? specialExamReason;
  //constructor
  SpecialExamsModel({
    this.studentName,
    this.studeRegNo,
    this.studeEmail,
    this.studePhone,
    this.studeUid,
    this.unitCode,
    this.unitName,
    this.unitLecturer,
    this.semesterStage,
    this.yearOfStudent,
    this.specialExamStatus,
    this.specialExamReason,
  });
  //copyWith method
  SpecialExamsModel copyWith({
    String? studentName,
    String? studeRegNo,
    String? studeEmail,
    String? studePhone,
    String? studeUid,
    String? unitCode,
    String? unitName,
    String? unitLecturer,
    String? semesterStage,
    String? yearOfStudent,
    String? specialExamStatus,
    String? specialExamReason,
  }) {
    return SpecialExamsModel(
      studentName: studentName ?? this.studentName,
      studeRegNo: studeRegNo ?? this.studeRegNo,
      studeEmail: studeEmail ?? this.studeEmail,
      studePhone: studePhone ?? this.studePhone,
      studeUid: studeUid ?? this.studeUid,
      unitCode: unitCode ?? this.unitCode,
      unitName: unitName ?? this.unitName,
      unitLecturer: unitLecturer ?? this.unitLecturer,
      semesterStage: semesterStage ?? this.semesterStage,
      yearOfStudent: yearOfStudent ?? this.yearOfStudent,
      specialExamStatus: specialExamStatus ?? this.specialExamStatus,
      specialExamReason: specialExamReason ?? this.specialExamReason,
    );
  }
  //to map

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'studentName': studentName,
      'studeRegNo': studeRegNo,
      'studeEmail': studeEmail,
      'studePhone': studePhone,
      'studeUid': studeUid,
      'unitCode': unitCode,
      'unitName': unitName,
      'unitLecturer': unitLecturer,
      'semesterStage': semesterStage,
      'yearOfStudent': yearOfStudent,
      'specialExamStatus': specialExamStatus,
      'specialExamReason': specialExamReason,
    };
  }

  factory SpecialExamsModel.fromMap(Map<String, dynamic> map) {
    return SpecialExamsModel(
      studentName: map['studentName'] != null
          ? map["studentName"] ?? '' as String
          : null,
      studeRegNo:
          map['studeRegNo'] != null ? map["studeRegNo"] ?? '' as String : null,
      studeEmail:
          map['studeEmail'] != null ? map["studeEmail"] ?? '' as String : null,
      studePhone:
          map['studePhone'] != null ? map["studePhone"] ?? '' as String : null,
      studeUid:
          map['studeUid'] != null ? map["studeUid"] ?? '' as String : null,
      unitCode:
          map['unitCode'] != null ? map["unitCode"] ?? '' as String : null,
      unitName:
          map['unitName'] != null ? map["unitName"] ?? '' as String : null,
      unitLecturer: map['unitLecturer'] != null
          ? map["unitLecturer"] ?? '' as String
          : null,
      semesterStage: map['semesterStage'] != null
          ? map["semesterStage"] ?? '' as String
          : null,
      yearOfStudent: map['yearOfStudent'] != null
          ? map["yearOfStudent"] ?? '' as String
          : null,
      specialExamStatus: map['specialExamStatus'] != null
          ? map["specialExamStatus"] ?? '' as String
          : null,
      specialExamReason: map['specialExamReason'] != null
          ? map["specialExamReason"] ?? '' as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SpecialExamsModel.fromJson(String source) =>
      SpecialExamsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
