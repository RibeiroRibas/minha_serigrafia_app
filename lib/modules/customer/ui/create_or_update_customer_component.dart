import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:formz/formz.dart';
import 'package:minhaserigrafia/modules/customer/cubit/create_or_update_customer_cubit.dart';
import 'package:minhaserigrafia/modules/customer/model/customer_model.dart';

class CreateOrUpdateCustomerComponent extends StatelessWidget {
  final CustomerModel customerModel;

  const CreateOrUpdateCustomerComponent({
    super.key,
    required this.customerModel,
  });

  @override
  Widget build(BuildContext context) {
    if (customerModel.id > 0) {
      BlocProvider.of<CreateOrUpdateCustomerCubit>(
        context,
      ).setModel(customerModel);
    }
    return Column(
      spacing: 8.0,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _NameInput(name: customerModel.name),
        const SizedBox(height: 12),
        _PhoneInput(phone: customerModel.phone),
        const SizedBox(height: 12),
        if (customerModel.createdAt.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  const TextSpan(text: 'Criado em: '),
                  TextSpan(
                    text: customerModel.createdAt,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        const SizedBox(height: 12),
        _SaveButton(customerId: customerModel.id),
      ],
    );
  }
}

class _NameInput extends StatefulWidget {
  final String name;

  const _NameInput({required this.name});

  @override
  State<_NameInput> createState() => _NameInputState();
}

class _NameInputState extends State<_NameInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.name);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (CreateOrUpdateCustomerCubit bloc) => bloc.state.name.displayError,
    );

    final customerNameInUse = context.select(
      (CreateOrUpdateCustomerCubit bloc) => bloc.state.customerNameInUse,
    );

    return TextField(
      controller: _controller,
      onChanged: (name) {
        BlocProvider.of<CreateOrUpdateCustomerCubit>(
          context,
        ).onNameChanged(name);
      },
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: 'Nome*',
        errorText: customerNameInUse
            ? 'Já existe um cliente registrado com esse nome.'
            : displayError != null
            ? 'Campo obrigatório.'
            : null,
      ),
    );
  }
}

class _PhoneInput extends StatefulWidget {
  final String phone;

  const _PhoneInput({required this.phone});

  @override
  State<_PhoneInput> createState() => _PhoneInputState();
}

class _PhoneInputState extends State<_PhoneInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.phone);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: (value) {
        BlocProvider.of<CreateOrUpdateCustomerCubit>(
          context,
        ).onPhoneChanged(value);
      },
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(labelText: 'Telefone'),
      keyboardType: TextInputType.number,
      inputFormatters: [MaskedInputFormatter('(##) #####-####')],
    );
  }
}

class _SaveButton extends StatelessWidget {
  final int customerId;

  const _SaveButton({required this.customerId});

  @override
  Widget build(BuildContext context) {
    final isInProgress = context.select(
      (CreateOrUpdateCustomerCubit bloc) => bloc.state.status.isInProgress,
    );

    if (isInProgress) return const CircularProgressIndicator();

    final isValid = context.select(
      (CreateOrUpdateCustomerCubit bloc) => bloc.state.isValid,
    );

    return ElevatedButton(
      onPressed: isValid && customerId == 0
          ? () => BlocProvider.of<CreateOrUpdateCustomerCubit>(
              context,
            ).onCreateCustomerSubmitted()
          : isValid && customerId > 0
          ? () => BlocProvider.of<CreateOrUpdateCustomerCubit>(
              context,
            ).onUpdateCustomerSubmitted()
          : null,
      child: const Text('Salvar'),
    );
  }
}
