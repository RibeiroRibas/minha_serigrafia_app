class ProductionStatisticsModel {
  final String totalThisMonth;
  final String totalToday;
  final String totalThisWeek;

  const ProductionStatisticsModel({
    this.totalThisMonth = '0',
    this.totalToday = '0',
    this.totalThisWeek = '0',
  });

  factory ProductionStatisticsModel.fromJson(Map<String, dynamic> json) {
    return ProductionStatisticsModel(
      totalThisMonth: (json['total_this_month'] as int? ?? 0).toString(),
      totalToday: (json['total_today'] as int? ?? 0).toString(),
      totalThisWeek: (json['total_this_week'] as int? ?? 0).toString(),
    );
  }
}
