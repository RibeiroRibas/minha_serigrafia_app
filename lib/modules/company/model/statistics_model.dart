class StatisticsModel {
  final String totalThisMonth;
  final String total;

  const StatisticsModel({this.totalThisMonth = '0', this.total = '0'});

  factory StatisticsModel.fromJson(Map<String, dynamic> json) {
    return StatisticsModel(
      totalThisMonth: (json['total_this_month'] as int? ?? 0).toString(),
      total: (json['total_today'] as int? ?? 0).toString(),
    );
  }
}
