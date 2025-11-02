part of 'prints_cubit.dart';

final class PrintsState extends Equatable {
  const PrintsState() : this._();

  const PrintsState._({
    this.status = FormzSubmissionStatus.inProgress,
    this.prints = const [],
    this.errorCode = 0,
  });

  final FormzSubmissionStatus status;
  final List<PrintResumedModel> prints;
  final int errorCode;

  PrintsState withSubmissionInProgress() {
    return PrintsState._(status: FormzSubmissionStatus.inProgress);
  }

  PrintsState withSubmissionSuccess({List<PrintResumedModel> prints = const []}) {
    return PrintsState._(status: FormzSubmissionStatus.success, prints: prints);
  }

  PrintsState withSubmissionFailure({int? errorCode}) {
    return PrintsState._(
      status: FormzSubmissionStatus.failure,
      errorCode: errorCode ?? this.errorCode,
    );
  }

  @override
  List<Object> get props => [status, errorCode, prints];
}
