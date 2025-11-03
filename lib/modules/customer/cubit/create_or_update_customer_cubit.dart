import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:minhaserigrafia/modules/customer/exceptions/customer_exception.dart';
import 'package:minhaserigrafia/modules/customer/model/customer_model.dart';
import 'package:minhaserigrafia/modules/customer/repository/customer_repository.dart';
import 'package:minhaserigrafia/shared/model/required_field.dart';

part 'create_or_update_customer_state.dart';

class CreateOrUpdateCustomerCubit extends Cubit<CreateOrUpdateCustomerState> {
  CreateOrUpdateCustomerCubit(this._customerRepository)
    : super(const CreateOrUpdateCustomerState());

  final CustomerRepository _customerRepository;

  void onNameChanged(String name) => emit(state.withName(name));

  void onPhoneChanged(String phone) => emit(state.withPhone(phone));

  Future<void> onCreateCustomerSubmitted() async {
    if (state.isValid) {
      emit(state.withSubmissionInProgress());
      try {
        await _customerRepository.createCustomer(
          name: state.name.value,
          phone: state.phone,
        );
        emit(state.withSubmissionSuccess());
      } on CustomerException catch (e) {
        emit(state.withSubmissionFailure(errorCode: e.code));
      } catch (_) {
        emit(state.withSubmissionFailure());
      }
    }
  }

  Future<void> onUpdateCustomerSubmitted() async {
    if (state.isValid) {
      emit(state.withSubmissionInProgress());
      try {
        await _customerRepository.updateCustomer(
          id: state.id,
          name: state.name.value,
          phone: state.phone,
        );
        emit(state.withSubmissionSuccess());
      } on CustomerException catch (e) {
        emit(state.withSubmissionFailure(errorCode: e.code));
      } catch (_) {
        emit(state.withSubmissionFailure());
      }
    }
  }

  void resetState() {
    emit(const CreateOrUpdateCustomerState());
  }

  void setModel(CustomerModel customerModel) {
    emit(state.fromModel(customerModel));
  }
}
