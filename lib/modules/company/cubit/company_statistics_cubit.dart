import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:minhaserigrafia/modules/company/exceptions/company_exception.dart';
import 'package:minhaserigrafia/modules/company/model/company_statistics_model.dart';
import 'package:minhaserigrafia/modules/company/repository/company_repository.dart';

part 'company_statistics_state.dart';

class CompanyStatisticsCubit extends Cubit<CompanyStatisticsState> {
  CompanyStatisticsCubit(this._companyRepository)
    : super(const CompanyStatisticsState());

  final CompanyRepository _companyRepository;

  Future<void> onGetCompanyStatisticsSubmitted() async {
    emit(state.withSubmissionInProgress());
    try {
      CompanyStatisticsModel companyStatistics = await _companyRepository
          .getStatistics();
      emit(state.withSubmissionSuccess(companyStatistics: companyStatistics));
    } on CompanyException catch (e) {
      emit(state.withSubmissionFailure(errorCode: e.code));
    } catch (_) {
      emit(state.withSubmissionFailure());
    }
  }
}
