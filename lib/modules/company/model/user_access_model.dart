class UserAccessModel {
  final int id;
  final String name;

  const UserAccessModel({
    this.id = 0,
    this.name = '',
  });

  factory UserAccessModel.fromJson(Map<String, dynamic> json) {
    return UserAccessModel(
      id: json['id'] as int? ?? 0,
      name: json['user_name'] as String? ?? '',
    );
  }
}
