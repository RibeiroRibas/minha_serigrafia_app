import 'package:minhaserigrafia/modules/frame/model/frame_print_model.dart';

class FrameModel {
  final int id;
  final String identifier;
  final String lastUsageAt;
  final String material;
  final String lines;
  final String size;
  final String createdAt;
  final List<FramePrintModel> prints;

  const FrameModel({
    this.lastUsageAt = '',
    this.id = 0,
    this.identifier = '',
    this.material = '',
    this.lines = '',
    this.size = '',
    this.createdAt = '',
    this.prints = const [],
  });

  factory FrameModel.fromJson(Map<String, dynamic> json) {
    final printsData = json['prints'] as List<dynamic>? ?? [];
    final List<FramePrintModel> prints = printsData
        .map((item) => FramePrintModel.fromJson(item as Map<String, dynamic>))
        .toList();

    return FrameModel(
      id: json['id'] as int? ?? 0,
      identifier: (json['identifier'] as int? ?? '').toString(),
      lastUsageAt: json['last_usage_at'] as String? ?? '',
      material: json['material'] as String? ?? '',
      lines: (json['lines'] as int? ?? '').toString(),
      size: json['size'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
      prints: prints,
    );
  }
}
