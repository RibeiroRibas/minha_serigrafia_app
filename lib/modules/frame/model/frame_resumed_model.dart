import 'package:minhaserigrafia/modules/frame/model/print_model.dart';

class FrameResumedModel {
  final int id;
  final int identifier;
  final String lastUsageAt;
  final List<PrintModel> prints;

  const FrameResumedModel({
    this.lastUsageAt = '',
    this.id = 0,
    this.identifier = 0,
    this.prints = const [],
  });

  factory FrameResumedModel.fromJson(Map<String, dynamic> json) {
    final printsData = json['prints'] as List<dynamic>? ?? [];
    final List<PrintModel> prints = printsData
        .map((item) => PrintModel.fromJson(item as Map<String, dynamic>))
        .toList();

    return FrameResumedModel(
      id: json['id'] as int? ?? 0,
      identifier: json['identifier'] as int? ?? 0,
      lastUsageAt: json['last_usage_at'] as String? ?? '',
      prints: prints,
    );
  }
}
