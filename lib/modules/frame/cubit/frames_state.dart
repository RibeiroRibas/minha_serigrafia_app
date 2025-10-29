part of 'frames_cubit.dart';

final class FramesState extends Equatable {
  const FramesState() : this._();

  const FramesState._({
    this.status = FormzSubmissionStatus.inProgress,
    this.frames = const [],
    this.errorCode = 0,
  });

  final FormzSubmissionStatus status;
  final List<FrameResumedModel> frames;
  final int errorCode;

  FramesState withSubmissionInProgress() {
    return FramesState._(status: FormzSubmissionStatus.inProgress);
  }

  FramesState withSubmissionSuccess({List<FrameResumedModel> frames = const []}) {
    return FramesState._(status: FormzSubmissionStatus.success, frames: frames);
  }

  FramesState withSubmissionFailure({int? errorCode, bool? isEmailInUse}) {
    return FramesState._(
      status: FormzSubmissionStatus.failure,
      errorCode: errorCode ?? this.errorCode,
    );
  }

  @override
  List<Object> get props => [status, errorCode, frames];
}
