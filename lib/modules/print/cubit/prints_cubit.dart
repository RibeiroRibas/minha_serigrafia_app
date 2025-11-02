import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:minhaserigrafia/modules/print/exceptions/print_exception.dart';
import 'package:minhaserigrafia/modules/print/model/print_resumed_model.dart';
import 'package:minhaserigrafia/modules/print/repository/print_repository.dart';

part 'prints_state.dart';

class PrintsCubit extends Cubit<PrintsState> {
  PrintsCubit(this._printRepository) : super(const PrintsState());

  final PrintRepository _printRepository;

  Future<void> onGetPrintsSubmitted({
    String? inputFilter,
    String? lastUsageOrderFilter,
  }) async {
    emit(state.withSubmissionInProgress());
    try {
      List<PrintResumedModel> prints = await _printRepository.getPrints(
        inputFilter: inputFilter,
        lastUsageOrderFilter: lastUsageOrderFilter,
      );
      emit(state.withSubmissionSuccess(prints: prints));
    } on PrintException catch (e) {
      emit(state.withSubmissionFailure(errorCode: e.code));
    } catch (_) {
      emit(state.withSubmissionFailure());
    }
  }

  Future<void> onDeletePrintSubmitted({required int printId}) async {
    emit(state.withSubmissionInProgress());
    try {
      await _printRepository.deletePrint(printId: printId);
      List<PrintResumedModel> prints = await _printRepository.getPrints();
      emit(state.withSubmissionSuccess(prints: prints));
    } on PrintException catch (e) {
      emit(state.withSubmissionFailure(errorCode: e.code));
    } catch (_) {
      emit(state.withSubmissionFailure());
    }
  }
}
