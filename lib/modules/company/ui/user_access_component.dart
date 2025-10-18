import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:formz/formz.dart';
import 'package:minhaserigrafia/modules/company/company_route_navigator.dart';
import 'package:minhaserigrafia/modules/company/cubit/company_info_cubit.dart';
import 'package:minhaserigrafia/modules/company/cubit/remove_access_cubit.dart';
import 'package:minhaserigrafia/modules/company/model/user_access_model.dart';
import 'package:minhaserigrafia/modules/signup/ui/primary_container_component.dart';
import 'package:minhaserigrafia/shared/error_messages.dart' as error_message;
import 'package:minhaserigrafia/shared/routes/route_named.dart';
import 'package:minhaserigrafia/shared/ui/custom_dialog.dart';
import 'package:minhaserigrafia/shared/ui/custom_snack_bar.dart';

class UserAccessComponent extends StatelessWidget {
  final VoidCallback onAccessCreated;
  final List<UserAccessModel> accesses;

  const UserAccessComponent({
    super.key,
    required this.accesses,
    required this.onAccessCreated,
  });

  @override
  Widget build(BuildContext context) {
    final navigator = Modular.get<CompanyRouteNavigator>();

    return Column(
      spacing: 16,
      children: [
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Acessos:', style: Theme.of(context).textTheme.titleMedium),
            SizedBox(
              width: 180,
              child: ElevatedButton(
                onPressed: () async {
                  navigator.pushNamed(
                    '$companyRoute$createAccessRoute',
                    arguments: {'onAccessCreated': onAccessCreated},
                  );
                },
                child: const Text('Incluir Acesso'),
              ),
            ),
          ],
        ),
        BlocListener<RemoveAccessCubit, RemoveAccessState>(
          listener: (context, state) =>
              _handleRemoveAccessState(state, context, navigator),
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 12);
            },
            shrinkWrap: true,
            itemCount: accesses.length,
            itemBuilder: (BuildContext context, int index) {
              return PrimaryContainerComponent(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(accesses[index].name),
                    _RemoveAccessButton(userId: accesses[index].id),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _handleRemoveAccessState(
    RemoveAccessState state,
    BuildContext context,
    CompanyRouteNavigator navigator,
  ) {
    if (state.status.isFailure) {
      final message = error_message.fromErrorCode(state.errorCode);
      showCustomSnackBar(context, message);
    } else if (state.status.isSuccess) {
      showCustomSnackBar(
        context,
        'Acesso removido com sucesso!',
        type: SnackBarType.success,
      );
      BlocProvider.of<CompanyInfoCubit>(context).onGetCompanyInfoSubmitted();
    }
  }
}

class _RemoveAccessButton extends StatelessWidget {
  final int userId;

  const _RemoveAccessButton({required this.userId});

  @override
  Widget build(BuildContext context) {
    final isInProgress = context.select(
      (RemoveAccessCubit bloc) =>
          bloc.state.status.isInProgress && bloc.state.deletingUserId == userId,
    );

    if (isInProgress) return CircularProgressIndicator();

    return IconButton(
      onPressed: () => confirmAction(
        context: context,
        onConfirm: () => BlocProvider.of<RemoveAccessCubit>(
          context,
        ).onDeleteAccessSubmitted(userId),
        message:
            'Tem certeza de que deseja remover este acesso?\nEsta ação não pode ser desfeita.',
      ),
      icon: const Icon(Icons.delete),
    );
  }
}
