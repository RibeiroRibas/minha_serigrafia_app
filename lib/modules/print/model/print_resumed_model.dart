class PrintResumedModel {
  final int id;
  final String name;
  final String customerName;
  final String lastUsageAt;
  final List<String> colorsHex;
  final List<String> framesIdentifiers;

  const PrintResumedModel({
    this.lastUsageAt = '',
    this.id = 0,
    this.name = '',
    this.customerName = '',
    this.colorsHex = const [],
    this.framesIdentifiers = const [],
  });

  factory PrintResumedModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> framesIdentifiers = json['frames_identifiers'] as List<dynamic>? ?? [];
    List<dynamic> colorsHex = json['colors_hex'] as List<dynamic>? ?? [];
    return PrintResumedModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      customerName: json['customer_name'] as String? ?? '',
      lastUsageAt: json['last_usage_at'] as String? ?? '',
      colorsHex: colorsHex.map((e) => e.toString()).toList(),
      framesIdentifiers: framesIdentifiers.map((e) => e.toString()).toList(),
    );
  }
}
