import 'package:dio/dio.dart';
import 'package:minhaserigrafia/infra/http/dio/dio_http_client.dart';
import 'package:minhaserigrafia/modules/core/service/current_auth_user_service.dart';
import 'package:minhaserigrafia/modules/print/model/print_model.dart';
import 'package:minhaserigrafia/modules/print/exceptions/print_exception.dart';
import 'package:minhaserigrafia/modules/print/model/print_resumed_model.dart';
import 'package:minhaserigrafia/settings.dart';

const String urlPrints = "api/app/v1/prints";

class PrintRepository {
  PrintRepository(this._httpClient, this._currentAuthUserService);

  final DioHttpClient _httpClient;
  final CurrentAuthUserService _currentAuthUserService;

  Future<void> createPrint({
    required String name,
    String? details,
    String? customerId,
    List<String> colorsHex = const [],
    required String lastUsageAt,
    List<int> framesIds = const [],
  }) async {
    final url = '${Settings.apiUrl}/$urlPrints';
    final data = {'name': name, 'colors_hex': colorsHex, 'frames_ids': framesIds};
    if (details != null) {
      data['details'] = details;
    }
    if (customerId != null && customerId.isNotEmpty) {
      data['customer_id'] = int.parse(customerId);
    }
    if (lastUsageAt.isNotEmpty) {
      data['last_usage_at'] = lastUsageAt;
    }
    final headers = {'Authorization': _currentAuthUserService.firebaseIdToken};
    try {
      await _httpClient.post(url, data: data, headers: headers);
    } on DioException catch (e) {
      final codeString = e.response?.data?['code']?.toString() ?? '0';
      final code = int.tryParse(codeString) ?? 0;
      throw PrintException(code);
    } catch (e) {
      throw Exception('Error during create print: ${e.toString()}');
    }
  }

  Future<List<PrintResumedModel>> getPrints({
    String? inputFilter,
    String? lastUsageOrderFilter,
  }) async {
    final url = '${Settings.apiUrl}/$urlPrints';
    final headers = {'Authorization': _currentAuthUserService.firebaseIdToken};
    final queryParameters = <String, dynamic>{};
    if (inputFilter != null && inputFilter.isNotEmpty) {
      queryParameters['filter_value'] = inputFilter;
    }
    if (lastUsageOrderFilter != null && lastUsageOrderFilter.isNotEmpty) {
      queryParameters['last_usage_order'] = lastUsageOrderFilter;
    }
    try {
      final List<dynamic> response = await _httpClient.get(
        url,
        headers: headers,
        queryParameters: queryParameters,
      );
      return response
          .map(
            (print) =>
                PrintResumedModel.fromJson(print as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e) {
      final codeString = e.response?.data?['code']?.toString() ?? '0';
      final code = int.tryParse(codeString) ?? 0;
      throw PrintException(code);
    } catch (e) {
      throw Exception('Error during get prints: ${e.toString()}');
    }
  }

  Future<void> updatePrint({
    required int id,
    required String name,
    String? details,
    String? customerId,
    List<String> colorsHex = const [],
    required String lastUsageAt,
    List<int> framesIds = const [],
  }) async {
    final url = '${Settings.apiUrl}/$urlPrints/$id';
    final data = {'name': name, 'colors_hex': colorsHex, 'frames_ids': framesIds};
    if (details != null) {
      data['details'] = details;
    }
    if (customerId != null && customerId.isNotEmpty) {
      data['customer_id'] = int.parse(customerId);
    }
    if (lastUsageAt.isNotEmpty) {
      data['last_usage_at'] = lastUsageAt;
    }
    final headers = {'Authorization': _currentAuthUserService.firebaseIdToken};
    try {
      await _httpClient.put(url, data: data, headers: headers);
    } on DioException catch (e) {
      final codeString = e.response?.data?['code']?.toString() ?? '0';
      final code = int.tryParse(codeString) ?? 0;
      throw PrintException(code);
    } catch (e) {
      throw Exception('Error during update print: ${e.toString()}');
    }
  }

  Future<PrintModel> getPrintById({required int printId}) async {
    final url = '${Settings.apiUrl}/$urlPrints/$printId';
    final headers = {'Authorization': _currentAuthUserService.firebaseIdToken};
    try {
      final Map<String, dynamic> response = await _httpClient.get(
        url,
        headers: headers,
      );
      return PrintModel.fromJson(response);
    } on DioException catch (e) {
      final codeString = e.response?.data?['code']?.toString() ?? '0';
      final code = int.tryParse(codeString) ?? 0;
      throw PrintException(code);
    } catch (e) {
      throw Exception('Error during get print by id: ${e.toString()}');
    }
  }

  Future<void> deletePrint({required int printId}) async {
    final url = '${Settings.apiUrl}/$urlPrints/$printId';
    final headers = {'Authorization': _currentAuthUserService.firebaseIdToken};
    try {
      await _httpClient.delete(url, headers: headers);
    } on DioException catch (e) {
      final codeString = e.response?.data?['code']?.toString() ?? '0';
      final code = int.tryParse(codeString) ?? 0;
      throw PrintException(code);
    } catch (e) {
      throw Exception('Error during delete print: ${e.toString()}');
    }
  }
}
