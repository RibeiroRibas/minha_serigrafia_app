enum UserType {
  admin,
  operator,
  unknow;

  factory UserType.fromString(String? userType) {
    switch (userType) {
      case 'admin':
        return UserType.admin;
      case 'operator':
        return UserType.operator;
      default:
        return UserType.unknow;
    }
  }
}
