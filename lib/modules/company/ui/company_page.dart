import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:formz/formz.dart';
import 'package:minhaserigrafia/modules/company/company_route_navigator.dart';
import 'package:minhaserigrafia/modules/company/cubit/company_info_cubit.dart';
import 'package:minhaserigrafia/modules/company/cubit/company_statistics_cubit.dart';
import 'package:minhaserigrafia/modules/company/ui/statistics_component.dart';
import 'package:minhaserigrafia/modules/company/ui/user_access_component.dart';
import 'package:minhaserigrafia/modules/signup/ui/generic_error_component.dart';
import 'package:minhaserigrafia/shared/ui/back_button_header_component.dart';

class CompanyPage extends StatefulWidget {
  const CompanyPage({super.key});

  @override
  State<CompanyPage> createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  final CompanyInfoCubit companyInfoCubit = Modular.get<CompanyInfoCubit>();
  final CompanyStatisticsCubit companyStatisticsCubit =
      Modular.get<CompanyStatisticsCubit>();
  final _navigator = Modular.get<CompanyRouteNavigator>();

  @override
  void initState() {
    super.initState();
    companyInfoCubit.onGetCompanyInfoSubmitted();
    companyStatisticsCubit.onGetCompanyStatisticsSubmitted();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                SizedBox(height: 8),
                BackButtonHeaderComponent(
                  title: 'Empresa',
                  onBackPressed: () => _navigator.pop(),
                ),
                BlocBuilder<CompanyInfoCubit, CompanyInfoState>(
                  bloc: companyInfoCubit,
                  builder: (context, state) {
                    if (state.status.isSuccess) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.companyInfo.name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Divider(),
                          UserAccessComponent(
                            accesses: state.companyInfo.accesses,
                            onAccessCreate: () =>
                                companyInfoCubit.onGetCompanyInfoSubmitted(),
                          ),
                        ],
                      );
                    }
                    if (state.status.isFailure) {
                      return GenericErrorComponent(
                        onRetry: () =>
                            companyInfoCubit.onGetCompanyInfoSubmitted(),
                        errorCode: state.errorCode,
                      );
                    }
                    return Center(child: const CircularProgressIndicator());
                  },
                ),
                Divider(),
                BlocBuilder<CompanyStatisticsCubit, CompanyStatisticsState>(
                  bloc: companyStatisticsCubit,
                  builder: (context, state) {
                    if (state.status.isSuccess) {
                      return StatisticsComponent(
                        companyStatistics: state.companyStatistics,
                      );
                    }
                    if (state.status.isFailure) {
                      return GenericErrorComponent(
                        onRetry: () =>
                            companyInfoCubit.onGetCompanyInfoSubmitted(),
                        errorCode: state.errorCode,
                      );
                    }
                    return Center(child: const CircularProgressIndicator());
                  },
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
