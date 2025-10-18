part of 'remove_access_cubit.dart';

final class RemoveAccessState extends Equatable {
  const RemoveAccessState() : this._();

  const RemoveAccessState._({
    this.status = FormzSubmissionStatus.initial,
    this.deletingUserId = 0,
    this.errorCode = 0,
  });

  final FormzSubmissionStatus status;
  final int errorCode;
  final int deletingUserId;

  RemoveAccessState withSubmissionInProgress({required int deletingUserId}) {
    return RemoveAccessState._(
      status: FormzSubmissionStatus.inProgress,
      deletingUserId: deletingUserId,
    );
  }

  RemoveAccessState withSubmissionSuccess() {
    return RemoveAccessState._(
      status: FormzSubmissionStatus.success,
      deletingUserId: 0,
    );
  }

  RemoveAccessState withSubmissionFailure({
    int? errorCode,
    bool? isEmailInUse,
  }) {
    return RemoveAccessState._(
      status: FormzSubmissionStatus.failure,
      errorCode: errorCode ?? this.errorCode,
      deletingUserId: 0,
    );
  }

  @override
  List<Object> get props => [status, errorCode, deletingUserId];
}
