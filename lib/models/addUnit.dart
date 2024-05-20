class AddUnitModel {
  String? unitId;
  String unitName;
  String unitCode;
  String unitLecturerName;
  String semesterStage;

//<editor-fold desc="Data Methods">
  AddUnitModel({
     this.unitId = "",
    required this.unitName,
    required this.unitCode,
    required this.unitLecturerName,
    required this.semesterStage,
  });

  AddUnitModel copyWith({
    String? unitId,
    String? unitName,
    String? unitCode,
    String? unitLecturerName,
    String? semesterStage,
  }) {
    return AddUnitModel(
      unitId: unitId ?? this.unitId,
      unitName: unitName ?? this.unitName,
      unitCode: unitCode ?? this.unitCode,
      unitLecturerName: unitLecturerName ?? this.unitLecturerName,
      semesterStage: semesterStage ?? this.semesterStage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'unitId': this.unitId,
      'unitName': this.unitName,
      'unitCode': this.unitCode,
      'unitLecturerName': this.unitLecturerName,
      'semesterStage': this.semesterStage,
    };
  }

  factory AddUnitModel.fromMap(Map<String, dynamic> map) {
    return AddUnitModel(
      unitId: map['unitId'] as String,
      unitName: map['unitName'] as String,
      unitCode: map['unitCode'] as String,
      unitLecturerName: map['unitLecturerName'] as String,
      semesterStage: map['semesterStage'] as String,
    );
  }
  @override
  String toString() {
    return 'AddUnitModel{' +
        ' unitId: $unitId,' +
        ' unitName: $unitName,' +
        ' unitCode: $unitCode,' +
        ' unitLecturerName: $unitLecturerName,' +
        ' semesterStage: $semesterStage,' +
        '}';
  }

//</editor-fold>
}
