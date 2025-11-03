part of 'customer_by_id_cubit.dart';

final class CustomerByIdState extends Equatable {
  const CustomerByIdState() : this._();

  const CustomerByIdState._({
    this.status = FormzSubmissionStatus.initial,
    this.customerModel = const CustomerModel(),
    this.errorCode = 0,
  });

  final FormzSubmissionStatus status;
  final CustomerModel customerModel;
  final int errorCode;

  CustomerByIdState withSubmissionInProgress() {
    return CustomerByIdState._(status: FormzSubmissionStatus.inProgress);
  }

  CustomerByIdState withSubmissionSuccess({
    required CustomerModel customerModel,
  }) {
    return CustomerByIdState._(
      status: FormzSubmissionStatus.success,
      customerModel: customerModel,
    );
  }

  CustomerByIdState withSubmissionFailure({int? errorCode}) {
    return CustomerByIdState._(
      status: FormzSubmissionStatus.failure,
      errorCode: errorCode ?? this.errorCode,
    );
  }

  @override
  List<Object> get props => [status, errorCode, customerModel];
}
