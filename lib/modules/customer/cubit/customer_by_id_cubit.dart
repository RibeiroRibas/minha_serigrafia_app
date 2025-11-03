import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:minhaserigrafia/modules/customer/exceptions/customer_exception.dart';
import 'package:minhaserigrafia/modules/customer/model/customer_model.dart';
import 'package:minhaserigrafia/modules/customer/repository/customer_repository.dart';

part 'customer_by_id_state.dart';

class CustomerByIdCubit extends Cubit<CustomerByIdState> {
  CustomerByIdCubit(this._customerRepository)
    : super(const CustomerByIdState());

  final CustomerRepository _customerRepository;

  Future<void> onGetCustomerByIdSubmitted({required int customerId}) async {
    emit(state.withSubmissionInProgress());
    try {
      CustomerModel customerModel = await _customerRepository.getCustomerById(
        customerId: customerId,
      );
      emit(state.withSubmissionSuccess(customerModel: customerModel));
    } on CustomerException catch (e) {
      emit(state.withSubmissionFailure(errorCode: e.code));
    } catch (_) {
      emit(state.withSubmissionFailure());
    }
  }

  void resetState() {
    emit(const CustomerByIdState());
  }
}
