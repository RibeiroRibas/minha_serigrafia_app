import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:minhaserigrafia/modules/print/exceptions/print_exception.dart';
import 'package:minhaserigrafia/modules/print/model/print_model.dart';
import 'package:minhaserigrafia/modules/print/repository/print_repository.dart';
import 'package:minhaserigrafia/shared/model/required_field.dart';

part 'create_or_update_print_state.dart';

class CreateOrUpdatePrintCubit extends Cubit<CreateOrUpdatePrintState> {
  CreateOrUpdatePrintCubit(this._printRepository)
    : super(const CreateOrUpdatePrintState());

  final PrintRepository _printRepository;

  void onNameChanged(String name) => emit(state.withName(name));

  void onCustomerIdChanged(String material) =>
      emit(state.withCustomerId(material));

  void onDetailsChanged(String details) => emit(state.withDetails(details));

  void onColorHexChanged(String colorHex) =>
      emit(state.withColorHex(colorHex));

  void onRemoveColorHex(String colorHex) =>
      emit(state.withoutColorHex(colorHex));

  void onLastUsageDateChanged(DateTime dateTime) =>
      emit(state.withLastUsageDate(dateTime));

  void onFrameIdChanged(int frameId) => emit(state.withFrameId(frameId));

  void onRemoveFrameId(int frameId) => emit(state.withoutFrameId(frameId));

  Future<void> onCreatePrintSubmitted() async {
    if (state.isValid) {
      emit(state.withSubmissionInProgress());
      try {
        await _printRepository.createPrint(
          name: state.name.value,
          details: state.details,
          customerId: state.customerId,
          colorsHex: state.colorsHex,
          lastUsageAt: state.lastUsageAt,
          framesIds: state.framesIds,
        );
        emit(state.withSubmissionSuccess());
      } on PrintException catch (e) {
        emit(state.withSubmissionFailure(errorCode: e.code));
      } catch (_) {
        emit(state.withSubmissionFailure());
      }
    }
  }

  Future<void> onUpdatePrintSubmitted() async {
    if (state.isValid) {
      emit(state.withSubmissionInProgress());
      try {
        await _printRepository.updatePrint(
          id: state.id,
          name: state.name.value,
          details: state.details,
          customerId: state.customerId,
          colorsHex: state.colorsHex,
          lastUsageAt: state.lastUsageAt,
          framesIds: state.framesIds,
        );
        emit(state.withSubmissionSuccess());
      } on PrintException catch (e) {
        emit(state.withSubmissionFailure(errorCode: e.code));
      } catch (_) {
        emit(state.withSubmissionFailure());
      }
    }
  }

  void resetState() {
    emit(const CreateOrUpdatePrintState());
  }

  void setModel(PrintModel printModel) {
    emit(state.fromModel(printModel));
  }
}
