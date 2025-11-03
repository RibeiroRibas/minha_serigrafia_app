class CustomerResumedModel {
  final int id;
  final String name;
  final String phone;

  const CustomerResumedModel({this.id = 0, this.name = '', this.phone = ''});

  factory CustomerResumedModel.fromJson(Map<String, dynamic> json) {
    return CustomerResumedModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      phone: json['cell_phone'] as String? ?? '',
    );
  }
}
