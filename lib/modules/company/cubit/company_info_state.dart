part of 'company_info_cubit.dart';

final class CompanyInfoState extends Equatable {
  const CompanyInfoState() : this._();

  const CompanyInfoState._({
    this.status = FormzSubmissionStatus.inProgress,
    this.companyInfo = const CompanyInfoModel(),
    this.errorCode = 0,
  });

  final FormzSubmissionStatus status;
  final CompanyInfoModel companyInfo;
  final int errorCode;

  CompanyInfoState withSubmissionInProgress() {
    return CompanyInfoState._(status: FormzSubmissionStatus.inProgress);
  }

  CompanyInfoState withSubmissionSuccess({
    required CompanyInfoModel companyInfo,
  }) {
    return CompanyInfoState._(
      status: FormzSubmissionStatus.success,
      companyInfo: companyInfo,
    );
  }

  CompanyInfoState withSubmissionFailure({int? errorCode, bool? isEmailInUse}) {
    return CompanyInfoState._(
        status: FormzSubmissionStatus.failure,
        errorCode: errorCode ?? this.errorCode);
  }

  @override
  List<Object> get props => [status, errorCode, companyInfo];
}
