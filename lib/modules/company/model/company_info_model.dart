import 'package:minhaserigrafia/modules/company/model/user_access_model.dart';

class CompanyInfoModel {
  final String name;
  final List<UserAccessModel> accesses;

  const CompanyInfoModel({this.name = '', this.accesses = const []});

  factory CompanyInfoModel.fromJson(Map<String, dynamic> json) {
    final accessesData = json['accesses'] as List<dynamic>? ?? [];
    final accessesList = accessesData
        .map((item) => UserAccessModel.fromJson(item as Map<String, dynamic>))
        .toList();

    return CompanyInfoModel(
      name: json['name'] as String? ?? '',
      accesses: accessesList,
    );
  }
}
