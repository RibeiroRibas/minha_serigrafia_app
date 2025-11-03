part of 'create_or_update_customer_cubit.dart';

final class CreateOrUpdateCustomerState extends Equatable {
  const CreateOrUpdateCustomerState() : this._();

  const CreateOrUpdateCustomerState._({
    this.status = FormzSubmissionStatus.initial,
    this.id = 0,
    this.name = const RequiredField.pure(),
    this.phone = '',
    this.customerNameInUse = false,
    this.errorCode = 0,
  });

  final FormzSubmissionStatus status;
  final int id;
  final RequiredField name;
  final String phone;
  final bool customerNameInUse;
  final int errorCode;

  const CreateOrUpdateCustomerState.initial() : this._();

  CreateOrUpdateCustomerState withName(String name) {
    return CreateOrUpdateCustomerState._(
      name: RequiredField.dirty(name),
      phone: phone,
      id: id,
    );
  }

  CreateOrUpdateCustomerState withPhone(String phone) {
    return CreateOrUpdateCustomerState._(phone: phone, name: name, id: id);
  }

  CreateOrUpdateCustomerState withSubmissionInProgress() {
    return CreateOrUpdateCustomerState._(
      status: FormzSubmissionStatus.inProgress,
      name: name,
      id: id,
      phone: phone,
    );
  }

  CreateOrUpdateCustomerState fromModel(CustomerModel customerModel) {
    return CreateOrUpdateCustomerState._(
      id: customerModel.id,
      name: RequiredField.dirty(customerModel.name),
      phone: customerModel.phone,
    );
  }

  CreateOrUpdateCustomerState withSubmissionSuccess() {
    return CreateOrUpdateCustomerState._(status: FormzSubmissionStatus.success);
  }

  CreateOrUpdateCustomerState withSubmissionFailure({int? errorCode}) {
    return CreateOrUpdateCustomerState._(
      name: name,
      id: id,
      phone: phone,
      status: FormzSubmissionStatus.failure,
      customerNameInUse: errorCode != null && errorCode == 400004,
      errorCode: errorCode ?? this.errorCode,
    );
  }

  bool get isValid => Formz.validate([name]);

  @override
  List<Object> get props => [
    status,
    id,
    name,
    errorCode,
    phone,
    customerNameInUse,
  ];
}
