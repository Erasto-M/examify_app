class AddUnitModel {
  String? unitId;
  String unitName;
  String unitCode;
  String unitLecturerName;
  String unitLecturerId;
  String semesterStage;
  String year;

//<editor-fold desc="Data Methods">
  AddUnitModel({
    this.unitId = "",
    required this.unitName,
    required this.unitCode,
    required this.unitLecturerName,
    required this.unitLecturerId,
    required this.semesterStage,
    required this.year,
  });

  AddUnitModel copyWith({
    String? unitId,
    String? unitName,
    String? unitCode,
    String? unitLecturerName,
    String? unitLecturerId,
    String? semesterStage,
    String? year,
  }) {
    return AddUnitModel(
      unitId: unitId ?? this.unitId,
      unitName: unitName ?? this.unitName,
      unitCode: unitCode ?? this.unitCode,
      unitLecturerName: unitLecturerName ?? this.unitLecturerName,
      unitLecturerId: unitLecturerName ?? this.unitLecturerId,
      semesterStage: semesterStage ?? this.semesterStage,
      year: year ?? this.year,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'unitId': this.unitId,
      'unitName': this.unitName,
      'unitCode': this.unitCode,
      'unitLecturerName': this.unitLecturerName,
      'unitLecturerId': this.unitLecturerId,
      'semesterStage': this.semesterStage,
      'year': this.year,
    };
  }

  factory AddUnitModel.fromMap(Map<String, dynamic> map) {
    return AddUnitModel(
      unitId: map['unitId'] as String,
      unitName: map['unitName'] as String,
      unitCode: map['unitCode'] as String,
      unitLecturerName: map['unitLecturerName'] as String,
      unitLecturerId: map['unitLecturerId'] as String,
      semesterStage: map['semesterStage'] as String,
      year: map['year'] as String,
    );
  }
  @override
  String toString() {
    return 'AddUnitModel{' +
        ' unitId: $unitId,' +
        ' unitName: $unitName,' +
        ' unitCode: $unitCode,' +
        ' unitLecturerName: $unitLecturerName,' +
        ' unitLecturerId: $unitLecturerId,' +
        ' semesterStage: $semesterStage,' +
        ' year: $year,' +
        '}';
  }

//</editor-fold>
}
