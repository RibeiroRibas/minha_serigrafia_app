import 'package:dio/dio.dart';
import 'package:minhaserigrafia/infra/http/dio/dio_http_client.dart';
import 'package:minhaserigrafia/modules/company/exceptions/company_exception.dart';
import 'package:minhaserigrafia/modules/company/model/company_info_model.dart';
import 'package:minhaserigrafia/modules/company/model/company_statistics_model.dart';
import 'package:minhaserigrafia/modules/core/service/current_auth_user_service.dart';
import 'package:minhaserigrafia/modules/signup/exceptions/email_in_use_exception.dart';
import 'package:minhaserigrafia/settings.dart';

const String urlCompany = "api/app/v1/companies";

class CompanyRepository {
  CompanyRepository(this._httpClient, this._currentAuthUserService);

  final DioHttpClient _httpClient;
  final CurrentAuthUserService _currentAuthUserService;

  Future<void> createAccess({
    required String userName,
    required String email,
    required String password,
  }) async {
    final url = '${Settings.apiUrl}/$urlCompany/access';
    final data = {'user_name': userName, 'email': email, 'password': password};
    final headers = {'Authorization': _currentAuthUserService.firebaseIdToken};
    try {
      await _httpClient.post(url, data: data, headers: headers);
    } on DioException catch (e) {
      final codeString = e.response?.data?['code']?.toString() ?? '0';
      final code = int.tryParse(codeString) ?? 0;
      if (codeString == '400001') {
        throw EmailInUseException(code);
      }
      throw CompanyException(code);
    } catch (e) {
      throw Exception('Error during create access: ${e.toString()}');
    }
  }

  Future<CompanyInfoModel> getCompanyInfo() async {
    final url = '${Settings.apiUrl}/$urlCompany/info';
    final headers = {'Authorization': _currentAuthUserService.firebaseIdToken};
    try {
      final response = await _httpClient.get(url, headers: headers);
      return CompanyInfoModel.fromJson(response);
    } on DioException catch (e) {
      final codeString = e.response?.data?['code']?.toString() ?? '0';
      final code = int.tryParse(codeString) ?? 0;
      throw CompanyException(code);
    } catch (e) {
      throw Exception('Error during get company info: ${e.toString()}');
    }
  }

  Future<CompanyStatisticsModel> getStatistics() async {
    final url = '${Settings.apiUrl}/$urlCompany/statistics';
    final headers = {'Authorization': _currentAuthUserService.firebaseIdToken};
    try {
      final response = await _httpClient.get(url, headers: headers);
      return CompanyStatisticsModel.fromJson(response);
    } on DioException catch (e) {
      final codeString = e.response?.data?['code']?.toString() ?? '0';
      final code = int.tryParse(codeString) ?? 0;
      throw CompanyException(code);
    } catch (e) {
      throw Exception('Error during get statistics: ${e.toString()}');
    }
  }

  Future<void> deleteAccess({required int userId}) async {
    final url = '${Settings.apiUrl}/$urlCompany/access/$userId';
    final headers = {'Authorization': _currentAuthUserService.firebaseIdToken};
    try {
      await _httpClient.delete(url, headers: headers);
    } on DioException catch (e) {
      final codeString = e.response?.data?['code']?.toString() ?? '0';
      final code = int.tryParse(codeString) ?? 0;
      throw CompanyException(code);
    } catch (e) {
      throw Exception('Error during delete access: ${e.toString()}');
    }
  }

  Future<void> deleteCompany() async {
    final url = '${Settings.apiUrl}/$urlCompany';
    final headers = {'Authorization': _currentAuthUserService.firebaseIdToken};
    try {
      await _httpClient.delete(url, headers: headers);
    } on DioException catch (e) {
      final codeString = e.response?.data?['code']?.toString() ?? '0';
      final code = int.tryParse(codeString) ?? 0;
      throw CompanyException(code);
    } catch (e) {
      throw Exception('Error during delete company: ${e.toString()}');
    }
  }
}
