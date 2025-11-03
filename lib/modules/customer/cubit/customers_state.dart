part of 'customers_cubit.dart';

final class CustomersState extends Equatable {
  const CustomersState() : this._();

  const CustomersState._({
    this.status = FormzSubmissionStatus.inProgress,
    this.customers = const [],
    this.errorCode = 0,
  });

  final FormzSubmissionStatus status;
  final List<CustomerResumedModel> customers;
  final int errorCode;

  CustomersState withSubmissionInProgress() {
    return CustomersState._(status: FormzSubmissionStatus.inProgress);
  }

  CustomersState withSubmissionSuccess({
    List<CustomerResumedModel> customers = const [],
  }) {
    return CustomersState._(
      status: FormzSubmissionStatus.success,
      customers: customers,
    );
  }

  CustomersState withSubmissionFailure({int? errorCode}) {
    return CustomersState._(
      status: FormzSubmissionStatus.failure,
      errorCode: errorCode ?? this.errorCode,
    );
  }

  @override
  List<Object> get props => [status, errorCode, customers];
}
