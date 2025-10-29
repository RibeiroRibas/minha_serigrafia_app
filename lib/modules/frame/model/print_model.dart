class PrintModel {
  final int id;
  final String customerName;
  final String printName;
  final List<String> colorsHex;

  const PrintModel({
    this.id = 0,
    this.customerName = '',
    this.printName = '',
    this.colorsHex = const [],
  });

  factory PrintModel.fromJson(Map<String, dynamic> json) {
    return PrintModel(
      id: json['id'] as int? ?? 0,
      customerName: json['customer_name'] as String? ?? '',
      printName: json['name'] as String? ?? '',
      colorsHex:
          (json['colors_hex'] as List<dynamic>?)
              ?.map((item) => item as String)
              .toList() ??
          [],
    );
  }
}
