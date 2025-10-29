import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:minhaserigrafia/modules/frame/exceptions/frame_exception.dart';
import 'package:minhaserigrafia/modules/frame/model/frame_model.dart';
import 'package:minhaserigrafia/modules/frame/repository/frame_repository.dart';

part 'frame_by_id_state.dart';

class FrameByIdCubit extends Cubit<FrameByIdState> {
  FrameByIdCubit(this._frameRepository) : super(const FrameByIdState());

  final FrameRepository _frameRepository;

  Future<void> onGetFrameByIdSubmitted({required int frameId}) async {
    emit(state.withSubmissionInProgress());
    try {
      FrameModel frameModel = await _frameRepository.getFrameById(
        frameId: frameId,
      );
      emit(state.withSubmissionSuccess(frameModel: frameModel));
    } on FrameException catch (e) {
      emit(state.withSubmissionFailure(errorCode: e.code));
    } catch (_) {
      emit(state.withSubmissionFailure());
    }
  }

  void resetState() {
    emit(const FrameByIdState());
  }
}
