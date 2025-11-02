import 'package:minhaserigrafia/modules/frame/model/frame_print_model.dart';

class FrameResumedModel {
  final int id;
  final int identifier;
  final String lastUsageAt;
  final List<FramePrintModel> prints;

  const FrameResumedModel({
    this.lastUsageAt = '',
    this.id = 0,
    this.identifier = 0,
    this.prints = const [],
  });

  factory FrameResumedModel.fromJson(Map<String, dynamic> json) {
    final printsData = json['prints'] as List<dynamic>? ?? [];
    final List<FramePrintModel> prints = printsData
        .map((item) => FramePrintModel.fromJson(item as Map<String, dynamic>))
        .toList();

    return FrameResumedModel(
      id: json['id'] as int? ?? 0,
      identifier: json['identifier'] as int? ?? 0,
      lastUsageAt: json['last_usage_at'] as String? ?? '',
      prints: prints,
    );
  }
}
