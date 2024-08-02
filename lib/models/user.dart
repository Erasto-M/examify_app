class UserModel {
  final String cohort;
  final String email;
  final String pfNumber;
  final String phoneNumber;
  final String registrationNumber;
  final String role;
  final String userId;
  final String userName;
  final String yearOfStudy;

  UserModel({
    required this.cohort,
    required this.email,
    required this.pfNumber,
    required this.phoneNumber,
    required this.registrationNumber,
    required this.role,
    required this.userId,
    required this.userName,
    required this.yearOfStudy,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      cohort: json['cohort'],
      email: json['email'],
      pfNumber: json['pfNumber'],
      phoneNumber: json['phoneNumber'],
      registrationNumber: json['registrationNumber'],
      role: json['role'],
      userId: json['userId'],
      userName: json['userName'],
      yearOfStudy: json['yearOfStudy'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cohort': cohort,
      'email': email,
      'pfNumber': pfNumber,
      'phoneNumber': phoneNumber,
      'registrationNumber': registrationNumber,
      'role': role,
      'userId': userId,
      'userName': userName,
      'yearOfStudy': yearOfStudy,
    };
  }
}
