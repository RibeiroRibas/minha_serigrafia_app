import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:formz/formz.dart';
import 'package:minhaserigrafia/infra/storage/secure_storage_repository.dart';
import 'package:minhaserigrafia/modules/company/company_route_navigator.dart';
import 'package:minhaserigrafia/modules/company/cubit/company_info_cubit.dart';
import 'package:minhaserigrafia/modules/company/cubit/company_statistics_cubit.dart';
import 'package:minhaserigrafia/modules/company/cubit/delete_company_cubit.dart';
import 'package:minhaserigrafia/modules/company/ui/statistics_component.dart';
import 'package:minhaserigrafia/modules/company/ui/user_access_component.dart';
import 'package:minhaserigrafia/modules/core/service/current_auth_user_service.dart';
import 'package:minhaserigrafia/modules/signup/ui/generic_error_component.dart';
import 'package:minhaserigrafia/shared/error_messages.dart' as error_message;
import 'package:minhaserigrafia/shared/model/user_type.dart';
import 'package:minhaserigrafia/shared/routes/route_named.dart';
import 'package:minhaserigrafia/shared/ui/back_button_header_component.dart';
import 'package:minhaserigrafia/shared/ui/custom_dialog.dart';
import 'package:minhaserigrafia/shared/ui/custom_snack_bar.dart';

class CompanyPage extends StatefulWidget {
  const CompanyPage({super.key});

  @override
  State<CompanyPage> createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  final CompanyStatisticsCubit companyStatisticsCubit =
      Modular.get<CompanyStatisticsCubit>();
  final _navigator = Modular.get<CompanyRouteNavigator>();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CompanyInfoCubit>(context).onGetCompanyInfoSubmitted();
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
                            onAccessCreated: () {
                              showCustomSnackBar(
                                context,
                                'Acesso criado com sucesso!',
                                type: SnackBarType.success,
                              );
                              BlocProvider.of<CompanyInfoCubit>(
                                context,
                              ).onGetCompanyInfoSubmitted();
                            },
                          ),
                        ],
                      );
                    }
                    if (state.status.isFailure) {
                      return GenericErrorComponent(
                        onRetry: () => BlocProvider.of<CompanyInfoCubit>(
                          context,
                        ).onGetCompanyInfoSubmitted(),
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
                        onRetry: () => BlocProvider.of<CompanyInfoCubit>(
                          context,
                        ).onGetCompanyInfoSubmitted(),
                        errorCode: state.errorCode,
                      );
                    }
                    return Center(child: const CircularProgressIndicator());
                  },
                ),
                Divider(),
                BlocListener<DeleteCompanyCubit, DeleteCompanyState>(
                  listener: (context, state) async =>
                      await _handleDeleteAccountState(state, context),
                  child: Visibility(
                    visible:
                        Modular.get<CurrentAuthUserService>().userType ==
                        UserType.admin,
                    child: _DeleteAccountButton(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleDeleteAccountState(
    DeleteCompanyState state,
    BuildContext context,
  ) async {
    if (state.status.isFailure) {
      final message = error_message.fromErrorCode(state.errorCode);
      showCustomSnackBar(context, message);
    } else if (state.status.isSuccess) {
      await Modular.get<SecureStorageRepository>().deleteAll();
      _navigator.goTo(signInRoute);
    }
  }
}

class _DeleteAccountButton extends StatelessWidget {
  const _DeleteAccountButton();

  @override
  Widget build(BuildContext context) {
    final isInProgress = context.select(
      (DeleteCompanyCubit bloc) => bloc.state.status.isInProgress,
    );

    return OutlinedButton(
      onPressed: () => confirmAction(
        context: context,
        onConfirm: () => BlocProvider.of<DeleteCompanyCubit>(
          context,
        ).onDeleteCompanySubmitted(),
        message:
            'Tem certeza de que deseja excluir esta conta?\nEsta ação não pode ser desfeita e todos os dados serao perdidos.',
      ),
      child: isInProgress
          ? Center(child: CircularProgressIndicator())
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Excluir Conta',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(color: Colors.red),
                ),
                const Icon(Icons.delete, size: 24, color: Colors.red),
              ],
            ),
    );
  }
}
