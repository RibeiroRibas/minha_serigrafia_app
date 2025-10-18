part of 'company_statistics_cubit.dart';

final class CompanyStatisticsState extends Equatable {
  const CompanyStatisticsState() : this._();

  const CompanyStatisticsState._({
    this.status = FormzSubmissionStatus.inProgress,
    this.companyStatistics = const CompanyStatisticsModel(),
    this.errorCode = 0,
  });

  final FormzSubmissionStatus status;
  final CompanyStatisticsModel companyStatistics;
  final int errorCode;

  CompanyStatisticsState withSubmissionInProgress() {
    return CompanyStatisticsState._(status: FormzSubmissionStatus.inProgress);
  }

  CompanyStatisticsState withSubmissionSuccess({
    required CompanyStatisticsModel companyStatistics,
  }) {
    return CompanyStatisticsState._(
      status: FormzSubmissionStatus.success,
      companyStatistics: companyStatistics,
    );
  }

  CompanyStatisticsState withSubmissionFailure({int? errorCode, bool? isEmailInUse}) {
    return CompanyStatisticsState._(errorCode: errorCode ?? this.errorCode);
  }

  @override
  List<Object> get props => [status, errorCode, companyStatistics];
}
