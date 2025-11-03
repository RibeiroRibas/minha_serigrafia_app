class CustomerModel {
  final int id;
  final String name;
  final String phone;
  final String createdAt;

  const CustomerModel({
    this.id = 0,
    this.name = '',
    this.phone = '',
    this.createdAt = '',
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      phone: json['cell_phone'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
    );
  }
}
