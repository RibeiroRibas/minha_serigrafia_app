import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:minhaserigrafia/modules/company/exceptions/company_exception.dart';
import 'package:minhaserigrafia/modules/company/model/company_info_model.dart';
import 'package:minhaserigrafia/modules/company/repository/company_repository.dart';

part 'company_info_state.dart';

class CompanyInfoCubit extends Cubit<CompanyInfoState> {
  CompanyInfoCubit(this._companyRepository) : super(const CompanyInfoState());

  final CompanyRepository _companyRepository;

  Future<void> onGetCompanyInfoSubmitted() async {
    emit(state.withSubmissionInProgress());
    try {
      CompanyInfoModel companyInfo = await _companyRepository.getCompanyInfo();
      emit(state.withSubmissionSuccess(companyInfo: companyInfo));
    } on CompanyException catch (e) {
      emit(state.withSubmissionFailure(errorCode: e.code));
    } catch (_) {
      emit(state.withSubmissionFailure());
    }
  }
}
