import 'package:dio/dio.dart';
import 'package:minhaserigrafia/infra/http/dio/dio_http_client.dart';
import 'package:minhaserigrafia/modules/core/service/current_auth_user_service.dart';
import 'package:minhaserigrafia/modules/signup/exceptions/email_in_use_exception.dart';
import 'package:minhaserigrafia/modules/signup/exceptions/sign_up_exception.dart';
import 'package:minhaserigrafia/settings.dart';

const String urlAuth = "api/app/v1/onboarding";

class SignUpRepository {
  SignUpRepository(this._httpClient, this._currentAuthUserService);

  final DioHttpClient _httpClient;
  final CurrentAuthUserService _currentAuthUserService;

  Future<dynamic> createAccount({
    required String userName,
    required String companyName,
    required String cellPhone,
    required String email,
    required String password,
  }) async {
    final url = '${Settings.apiUrl}/$urlAuth/account';
    final data = {
      'user_name': userName,
      'company_name': companyName,
      'cell_phone': cellPhone,
      'email': email,
      'password': password,
    };
    try {
      final response = await _httpClient.post(url, data: data);
      return response;
    } on DioException catch (e) {
      final codeString = e.response?.data?['code']?.toString() ?? '0';
      final code = int.tryParse(codeString) ?? 0;
      if (codeString == '400001') {
        throw EmailInUseException(code);
      }
      throw SignUpException(code);
    } catch (e) {
      throw Exception('Error during sign up: ${e.toString()}');
    }
  }

  Future<dynamic> completeSignUp({
    required String companyName,
    required String cellPhone,
  }) async {
    final url = '${Settings.apiUrl}/$urlAuth/account';
    final data = {'company_name': companyName, 'cell_phone': cellPhone};
    final headers = {'Authorization': _currentAuthUserService.firebaseIdToken};
    try {
      final response = await _httpClient.put(url, data: data, headers: headers);
      return response;
    } on DioException catch (e) {
      final codeString = e.response?.data?['code']?.toString() ?? '0';
      final code = int.tryParse(codeString) ?? 0;
      throw SignUpException(code);
    } catch (e) {
      throw Exception('Error during complete sign up: ${e.toString()}');
    }
  }
}
