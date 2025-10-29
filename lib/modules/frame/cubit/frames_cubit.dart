import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:minhaserigrafia/modules/frame/exceptions/frame_exception.dart';
import 'package:minhaserigrafia/modules/frame/model/frame_resumed_model.dart';
import 'package:minhaserigrafia/modules/frame/repository/frame_repository.dart';

part 'frames_state.dart';

class FramesCubit extends Cubit<FramesState> {
  FramesCubit(this._frameRepository) : super(const FramesState());

  final FrameRepository _frameRepository;

  Future<void> onGetFramesSubmitted({
    String? inputFilter,
    String? lastUsageOrderFilter,
  }) async {
    emit(state.withSubmissionInProgress());
    try {
      List<FrameResumedModel> frames = await _frameRepository.getFrames(
        inputFilter: inputFilter,
        lastUsageOrderFilter: lastUsageOrderFilter,
      );
      emit(state.withSubmissionSuccess(frames: frames));
    } on FrameException catch (e) {
      emit(state.withSubmissionFailure(errorCode: e.code));
    } catch (_) {
      emit(state.withSubmissionFailure());
    }
  }

  Future<void> onDeleteFrameSubmitted({required int frameId}) async {
    emit(state.withSubmissionInProgress());
    try {
      await _frameRepository.deleteFrame(frameId: frameId);
      List<FrameResumedModel> frames = await _frameRepository.getFrames();
      emit(state.withSubmissionSuccess(frames: frames));
    } on FrameException catch (e) {
      emit(state.withSubmissionFailure(errorCode: e.code));
    } catch (_) {
      emit(state.withSubmissionFailure());
    }
  }
}
