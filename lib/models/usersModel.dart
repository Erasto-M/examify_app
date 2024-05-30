class AppUser {
  String? userName;
  String? email;
  String? phoneNumber;
  String? role;
  String? userId;

  AppUser({
    this.userName,
    this.email,
    this.phoneNumber,
    this.role,
    this.userId,
  });

  AppUser copyWith({
    String? userName,
    String? email,
    String? phoneNumber,
    String? role,
    String? userId,
  }) {
    return AppUser(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': this.userName,
      'email': this.email,
      'phoneNumber': this.phoneNumber,
      'role': this.role,
      'userId': this.userId,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      userName: map['userName'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
      role: map['role'] as String,
      userId: map['userId'] as String,
    );
  }

  @override
  String toString() {
    return 'AppUser{' +
        ' userName: $userName,' +
        ' email: $email,' +
        ' phoneNumber: $phoneNumber,' +
        ' role: $role,' +
        ' userId: $userId,' +
        '}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppUser &&
        other.userName == userName &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.role == role &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return userName.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        role.hashCode ^
        userId.hashCode;
  }

  AppUser.fromJson(Map<String, dynamic> json)
      : userName = json['userName'],
        email = json['email'],
        phoneNumber = json['phoneNumber'],
        role = json['role'],
        userId = json['userId'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['role'] = role;
    data['userId'] = userId;
    return data;
  }

  static List<AppUser> fromJsonList(List list) {
    return list.map((item) => AppUser.fromJson(item)).toList();
  }

  static List<Map<String, dynamic>> toJsonList(List<AppUser> users) {
    return users.map((item) => item.toJson()).toList();
  }

  

}
