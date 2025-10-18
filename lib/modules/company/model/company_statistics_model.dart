import 'package:minhaserigrafia/modules/company/model/production_statistics_model.dart';
import 'package:minhaserigrafia/modules/company/model/statistics_model.dart';

class CompanyStatisticsModel {
  final StatisticsModel customer;
  final ProductionStatisticsModel production;
  final StatisticsModel frame;
  final StatisticsModel print;

  const CompanyStatisticsModel({
    this.customer = const StatisticsModel(),
    this.production = const ProductionStatisticsModel(),
    this.frame = const StatisticsModel(),
    this.print = const StatisticsModel(),
  });

  factory CompanyStatisticsModel.fromJson(Map<String, dynamic> json) {
    return CompanyStatisticsModel(
      customer: StatisticsModel.fromJson(
        json['customer'] as Map<String, dynamic>? ?? {},
      ),
      production: ProductionStatisticsModel.fromJson(
        json['production'] as Map<String, dynamic>? ?? {},
      ),
      frame: StatisticsModel.fromJson(
        json['frame'] as Map<String, dynamic>? ?? {},
      ),
      print: StatisticsModel.fromJson(
        json['print'] as Map<String, dynamic>? ?? {},
      ),
    );
  }
}
