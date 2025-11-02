import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:minhaserigrafia/modules/print/exceptions/print_exception.dart';
import 'package:minhaserigrafia/modules/print/model/print_model.dart';
import 'package:minhaserigrafia/modules/print/repository/print_repository.dart';

part 'print_by_id_state.dart';

class PrintByIdCubit extends Cubit<PrintByIdState> {
  PrintByIdCubit(this._printRepository) : super(const PrintByIdState());

  final PrintRepository _printRepository;

  Future<void> onGetPrintByIdSubmitted({required int printId}) async {
    emit(state.withSubmissionInProgress());
    try {
      PrintModel printModel = await _printRepository.getPrintById(
        printId: printId,
      );
      emit(state.withSubmissionSuccess(printModel: printModel));
    } on PrintException catch (e) {
      emit(state.withSubmissionFailure(errorCode: e.code));
    } catch (_) {
      emit(state.withSubmissionFailure());
    }
  }

  void resetState() {
    emit(const PrintByIdState());
  }
}
