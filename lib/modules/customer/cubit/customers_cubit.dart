import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:minhaserigrafia/modules/customer/exceptions/customer_exception.dart';
import 'package:minhaserigrafia/modules/customer/model/customer_resumed_model.dart';
import 'package:minhaserigrafia/modules/customer/repository/customer_repository.dart';

part 'customers_state.dart';

class CustomersCubit extends Cubit<CustomersState> {
  CustomersCubit(this._customerRepository) : super(const CustomersState());

  final CustomerRepository _customerRepository;

  Future<void> onGetCustomerSubmitted({String? customerName}) async {
    emit(state.withSubmissionInProgress());
    try {
      List<CustomerResumedModel> customers = await _customerRepository
          .getCustomers(customerName: customerName);
      emit(state.withSubmissionSuccess(customers: customers));
    } on CustomerException catch (e) {
      emit(state.withSubmissionFailure(errorCode: e.code));
    } catch (_) {
      emit(state.withSubmissionFailure());
    }
  }

  Future<void> onDeleteCustomerSubmitted({required int customerId}) async {
    emit(state.withSubmissionInProgress());
    try {
      await _customerRepository.deleteCustomer(customerId: customerId);
      List<CustomerResumedModel> customers = await _customerRepository
          .getCustomers();
      emit(state.withSubmissionSuccess(customers: customers));
    } on CustomerException catch (e) {
      emit(state.withSubmissionFailure(errorCode: e.code));
    } catch (_) {
      emit(state.withSubmissionFailure());
    }
  }
}
