part of 'delete_company_cubit.dart';

final class DeleteCompanyState extends Equatable {
  const DeleteCompanyState() : this._();

  const DeleteCompanyState._({
    this.status = FormzSubmissionStatus.initial,
    this.errorCode = 0,
  });

  final FormzSubmissionStatus status;
  final int errorCode;

  DeleteCompanyState withSubmissionInProgress() {
    return DeleteCompanyState._(
      status: FormzSubmissionStatus.inProgress
    );
  }

  DeleteCompanyState withSubmissionSuccess() {
    return DeleteCompanyState._(
      status: FormzSubmissionStatus.success,
    );
  }

  DeleteCompanyState withSubmissionFailure({
    int? errorCode,
    bool? isEmailInUse,
  }) {
    return DeleteCompanyState._(
      status: FormzSubmissionStatus.failure,
      errorCode: errorCode ?? this.errorCode,
    );
  }

  @override
  List<Object> get props => [status, errorCode];
}
