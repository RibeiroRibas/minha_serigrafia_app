import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:minhaserigrafia/modules/frame/exceptions/frame_exception.dart';
import 'package:minhaserigrafia/modules/frame/model/frame_material_enum.dart';
import 'package:minhaserigrafia/modules/frame/model/frame_model.dart';
import 'package:minhaserigrafia/modules/frame/repository/frame_repository.dart';
import 'package:minhaserigrafia/shared/model/required_field.dart';

part 'create_or_update_frame_state.dart';

class CreateOrUpdateFrameCubit extends Cubit<CreateOrUpdateFrameState> {
  CreateOrUpdateFrameCubit(this._frameRepository)
    : super(const CreateOrUpdateFrameState());

  final FrameRepository _frameRepository;

  void onIdentifierChanged(String identifier) =>
      emit(state.withIdentifier(identifier));

  void onMaterialChanged(FrameMaterial material) =>
      emit(state.withMaterial(material));

  void onLinesChanged(String lines) => emit(state.withLines(lines));

  void onSizeChanged(String size) => emit(state.withSize(size));

  void onPrintIdChanged(int printId) =>
      emit(state.withPrintId(printId));
  
  void onRemovePrintId(int printId) =>
      emit(state.withoutPrintId(printId));

  void onLastUsageDateChanged(DateTime dateTime) =>
      emit(state.withLastUsageDate(dateTime));

  Future<void> onCreateFrameSubmitted() async {
    if (state.isValid) {
      emit(state.withSubmissionInProgress());
      try {
        await _frameRepository.createFrame(
          identifier: state.identifier.value,
          size: state.size,
          material: state.material,
          lines: state.lines,
          printsIds: state.printsIds,
          lastUsageAt: state.lastUsageAt,
        );
        emit(state.withSubmissionSuccess());
      } on FrameException catch (e) {
        emit(state.withSubmissionFailure(errorCode: e.code));
      } catch (_) {
        emit(state.withSubmissionFailure());
      }
    }
  }

  Future<void> onUpdateFrameSubmitted() async {
    if (state.isValid) {
      emit(state.withSubmissionInProgress());
      try {
        await _frameRepository.updateFrame(
          id: state.id,
          identifier: state.identifier.value,
          size: state.size,
          material: state.material,
          lines: state.lines,
          printsIds: state.printsIds,
          lastUsageAt: state.lastUsageAt,
        );
        emit(state.withSubmissionSuccess());
      } on FrameException catch (e) {
        emit(state.withSubmissionFailure(errorCode: e.code));
      } catch (_) {
        emit(state.withSubmissionFailure());
      }
    }
  }

  void resetState() {
    emit(const CreateOrUpdateFrameState());
  }

  void setModel(FrameModel frameModel) {
    emit(state.fromModel(frameModel));
  }
}
