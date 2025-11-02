class PrintFrameModel {
  final int id;
  final int identifier;

  const PrintFrameModel({this.id = 0, this.identifier = 0});

  factory PrintFrameModel.fromJson(Map<String, dynamic> json) {
    return PrintFrameModel(
      id: json['id'] as int? ?? 0,
      identifier: json['identifier'] as int? ?? 0,
    );
  }
}
