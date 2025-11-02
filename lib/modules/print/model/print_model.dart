import 'package:minhaserigrafia/modules/print/model/print_frame_model.dart';

class PrintModel {
  final int id;
  final String name;
  final String customerName;
  final String customerId;
  final String details;
  final String lastUsageAt;
  final String createdAt;
  final List<String> colorsHex;
  final List<PrintFrameModel> frames;

  const PrintModel({
    this.lastUsageAt = '',
    this.id = 0,
    this.name = '',
    this.customerName = '',
    this.customerId = '',
    this.details = '',
    this.colorsHex = const [],
    this.createdAt = '',
    this.frames = const [],
  });

  factory PrintModel.fromJson(Map<String, dynamic> json) {
    final framesData = json['frames'] as List<dynamic>? ?? [];
    final List<PrintFrameModel> frames = framesData
        .map((item) => PrintFrameModel.fromJson(item as Map<String, dynamic>))
        .toList();

    List<dynamic> colorsHex = json['colors_hex'] as List<dynamic>? ?? [];
    return PrintModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      customerName: json['customer_name'] as String? ?? '',
      customerId: (json['customer_id'] as int? ?? '').toString(),
      lastUsageAt: json['last_usage_at'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
      colorsHex: colorsHex.map((e) => e.toString()).toList(),
      frames: frames,
      details: json['details'] as String? ?? '',
    );
  }
}
