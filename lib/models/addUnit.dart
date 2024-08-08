// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AddUnitModel {
  String? unitId;
  String unitName;
  String unitCode;
  String unitLecturerName;
  String unitLecturerId;
  String semesterStage;
  String? unitDepartment;
  String year;

//<editor-fold desc="Data Methods">
  AddUnitModel({
    this.unitId = "",
    required this.unitName,
    required this.unitCode,
    required this.unitLecturerName,
    required this.unitLecturerId,
    required this.semesterStage,
    this.unitDepartment = 'BSC Computer Science',
    required this.year,
  });

  AddUnitModel copyWith({
    String? unitId,
    String? unitName,
    String? unitCode,
    String? unitLecturerName,
    String? unitLecturerId,
    String? semesterStage,
    String? unitDepartment,
    String? year,
  }) {
    return AddUnitModel(
      unitId: unitId ?? this.unitId,
      unitName: unitName ?? this.unitName,
      unitCode: unitCode ?? this.unitCode,
      unitLecturerName: unitLecturerName ?? this.unitLecturerName,
      unitLecturerId: unitLecturerId ?? this.unitLecturerId,
      semesterStage: semesterStage ?? this.semesterStage,
      unitDepartment: unitDepartment ?? this.unitDepartment,
      year: year ?? this.year,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'unitId': unitId,
      'unitName': unitName,
      'unitCode': unitCode,
      'unitLecturerName': unitLecturerName,
      'unitLecturerId': unitLecturerId,
      'semesterStage': semesterStage,
      'unitDepartment': unitDepartment,
      'year': year,
    };
  }

  factory AddUnitModel.fromMap(Map<String, dynamic> map) {
    return AddUnitModel(
      unitId: map['unitId'] != null ? map["unitId"] ?? '' as String : null,
      unitName: (map["unitName"] ?? '') as String,
      unitCode: (map["unitCode"] ?? '') as String,
      unitLecturerName: (map["unitLecturerName"] ?? '') as String,
      unitLecturerId: (map["unitLecturerId"] ?? '') as String,
      semesterStage: (map["semesterStage"] ?? '') as String,
      unitDepartment:
          (map["unitDepartment"] ?? 'BSC Computer Science') as String,
      year: (map["year"] ?? '') as String,
    );
  }
  @override
  String toString() {
    return 'AddUnitModel(unitId: $unitId, unitName: $unitName, unitCode: $unitCode, unitLecturerName: $unitLecturerName, unitLecturerId: $unitLecturerId, semesterStage: $semesterStage, unitDepartment: $unitDepartment, year: $year)';
  }

//</editor-fold>

  String toJson() => json.encode(toMap());

  factory AddUnitModel.fromJson(String source) =>
      AddUnitModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant AddUnitModel other) {
    if (identical(this, other)) return true;

    return other.unitId == unitId &&
        other.unitName == unitName &&
        other.unitCode == unitCode &&
        other.unitLecturerName == unitLecturerName &&
        other.unitLecturerId == unitLecturerId &&
        other.semesterStage == semesterStage &&
        other.unitDepartment == unitDepartment &&
        other.year == year;
  }

  @override
  int get hashCode {
    return unitId.hashCode ^
        unitName.hashCode ^
        unitCode.hashCode ^
        unitLecturerName.hashCode ^
        unitLecturerId.hashCode ^
        semesterStage.hashCode ^
        unitDepartment.hashCode ^
        year.hashCode;
  }
}
