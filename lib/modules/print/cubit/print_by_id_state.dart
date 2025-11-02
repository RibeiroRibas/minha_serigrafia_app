part of 'print_by_id_cubit.dart';

final class PrintByIdState extends Equatable {
  const PrintByIdState() : this._();

  const PrintByIdState._({
    this.status = FormzSubmissionStatus.initial,
    this.printModel = const PrintModel(),
    this.errorCode = 0,
  });

  final FormzSubmissionStatus status;
  final PrintModel printModel;
  final int errorCode;

  PrintByIdState withSubmissionInProgress() {
    return PrintByIdState._(status: FormzSubmissionStatus.inProgress);
  }

  PrintByIdState withSubmissionSuccess({required PrintModel printModel}) {
    return PrintByIdState._(
      status: FormzSubmissionStatus.success,
      printModel: printModel,
    );
  }

  PrintByIdState withSubmissionFailure({int? errorCode}) {
    return PrintByIdState._(
      status: FormzSubmissionStatus.failure,
      errorCode: errorCode ?? this.errorCode,
    );
  }

  @override
  List<Object> get props => [status, errorCode, printModel];
}
