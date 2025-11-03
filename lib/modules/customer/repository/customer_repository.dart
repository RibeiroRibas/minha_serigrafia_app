import 'package:dio/dio.dart';
import 'package:minhaserigrafia/infra/http/dio/dio_http_client.dart';
import 'package:minhaserigrafia/modules/core/service/current_auth_user_service.dart';
import 'package:minhaserigrafia/modules/customer/exceptions/customer_exception.dart';
import 'package:minhaserigrafia/modules/customer/model/customer_model.dart';
import 'package:minhaserigrafia/modules/customer/model/customer_resumed_model.dart';
import 'package:minhaserigrafia/settings.dart';

const String urlCustomers = "api/app/v1/customers";

class CustomerRepository {
  CustomerRepository(this._httpClient, this._currentAuthUserService);

  final DioHttpClient _httpClient;
  final CurrentAuthUserService _currentAuthUserService;

  Future<void> createCustomer({
    required String name,
    required String phone,
  }) async {
    final url = '${Settings.apiUrl}/$urlCustomers';
    final data = {'name': name};
    if (phone.isNotEmpty) {
      data['cell_phone'] = phone;
    }
    final headers = {'Authorization': _currentAuthUserService.firebaseIdToken};
    try {
      await _httpClient.post(url, data: data, headers: headers);
    } on DioException catch (e) {
      final codeString = e.response?.data?['code']?.toString() ?? '0';
      final code = int.tryParse(codeString) ?? 0;
      throw CustomerException(code);
    } catch (e) {
      throw Exception('Error during create customer: ${e.toString()}');
    }
  }

  Future<List<CustomerResumedModel>> getCustomers({String? customerName}) async {
    final url = '${Settings.apiUrl}/$urlCustomers';
    final headers = {'Authorization': _currentAuthUserService.firebaseIdToken};
    final queryParameters = <String, dynamic>{};
    if (customerName != null && customerName.isNotEmpty) {
      queryParameters['customer_name'] = customerName;
    }

    try {
      final List<dynamic> response = await _httpClient.get(
        url,
        headers: headers,
        queryParameters: queryParameters,
      );
      return response
          .map(
            (customer) =>
                CustomerResumedModel.fromJson(customer as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e) {
      final codeString = e.response?.data?['code']?.toString() ?? '0';
      final code = int.tryParse(codeString) ?? 0;
      throw CustomerException(code);
    } catch (e) {
      throw Exception('Error during get customers: ${e.toString()}');
    }
  }

  Future<void> updateCustomer({
    required int id,
    required String name,
    required String phone,
  }) async {
    final url = '${Settings.apiUrl}/$urlCustomers/$id';
    final data = {'name': name};
    if (phone.isNotEmpty) {
      data['cell_phone'] = phone;
    }
    final headers = {'Authorization': _currentAuthUserService.firebaseIdToken};
    try {
      await _httpClient.put(url, data: data, headers: headers);
    } on DioException catch (e) {
      final codeString = e.response?.data?['code']?.toString() ?? '0';
      final code = int.tryParse(codeString) ?? 0;
      throw CustomerException(code);
    } catch (e) {
      throw Exception('Error during update customer: ${e.toString()}');
    }
  }

  Future<CustomerModel> getCustomerById({required int customerId}) async {
    final url = '${Settings.apiUrl}/$urlCustomers/$customerId';
    final headers = {'Authorization': _currentAuthUserService.firebaseIdToken};
    try {
      final Map<String, dynamic> response = await _httpClient.get(
        url,
        headers: headers,
      );
      return CustomerModel.fromJson(response);
    } on DioException catch (e) {
      final codeString = e.response?.data?['code']?.toString() ?? '0';
      final code = int.tryParse(codeString) ?? 0;
      throw CustomerException(code);
    } catch (e) {
      throw Exception('Error during get customer by id: ${e.toString()}');
    }
  }

  Future<void> deleteCustomer({required int customerId}) async {
    final url = '${Settings.apiUrl}/$urlCustomers/$customerId';
    final headers = {'Authorization': _currentAuthUserService.firebaseIdToken};
    try {
      await _httpClient.delete(url, headers: headers);
    } on DioException catch (e) {
      final codeString = e.response?.data?['code']?.toString() ?? '0';
      final code = int.tryParse(codeString) ?? 0;
      throw CustomerException(code);
    } catch (e) {
      throw Exception('Error during delete customer: ${e.toString()}');
    }
  }
}
