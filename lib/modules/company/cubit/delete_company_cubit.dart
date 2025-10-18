import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:minhaserigrafia/modules/company/exceptions/company_exception.dart';
import 'package:minhaserigrafia/modules/company/repository/company_repository.dart';

part 'delete_company_state.dart';

class DeleteCompanyCubit extends Cubit<DeleteCompanyState> {
  DeleteCompanyCubit(this._companyRepository) : super(const DeleteCompanyState());

  final CompanyRepository _companyRepository;

  Future<void> onDeleteCompanySubmitted() async {
    emit(state.withSubmissionInProgress());
    try {
      await _companyRepository.deleteCompany();
      emit(state.withSubmissionSuccess());
    } on CompanyException catch (e) {
      emit(state.withSubmissionFailure(errorCode: e.code));
    } catch (_) {
      emit(state.withSubmissionFailure());
    }
  }
}
