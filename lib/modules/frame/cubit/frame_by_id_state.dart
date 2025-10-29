part of 'frame_by_id_cubit.dart';

final class FrameByIdState extends Equatable {
  const FrameByIdState() : this._();

  const FrameByIdState._({
    this.status = FormzSubmissionStatus.initial,
    this.frameModel = const FrameModel(),
    this.errorCode = 0,
  });

  final FormzSubmissionStatus status;
  final FrameModel frameModel;
  final int errorCode;

  FrameByIdState withSubmissionInProgress() {
    return FrameByIdState._(status: FormzSubmissionStatus.inProgress);
  }

  FrameByIdState withSubmissionSuccess({required FrameModel frameModel}) {
    return FrameByIdState._(
      status: FormzSubmissionStatus.success,
      frameModel: frameModel,
    );
  }

  FrameByIdState withSubmissionFailure({int? errorCode, bool? isEmailInUse}) {
    return FrameByIdState._(
      status: FormzSubmissionStatus.failure,
      errorCode: errorCode ?? this.errorCode,
    );
  }

  @override
  List<Object> get props => [status, errorCode, frameModel];
}
