import 'package:dio/dio.dart';
import 'package:minhaserigrafia/infra/http/dio/dio_http_client.dart';
import 'package:minhaserigrafia/modules/signin/exceptions/custom_auth_exception.dart';
import 'package:minhaserigrafia/settings.dart';

const String urlAuth = "api/app/v1/auth";

class CustomAuthRepository {
  CustomAuthRepository(this.httpClient);

  final DioHttpClient httpClient;

  Future<dynamic> login({required String firebaseIdToken}) async {
    final url = '${Settings.apiUrl}/$urlAuth/login';
    final headers = {'firebase-id-token': firebaseIdToken};
    try {
      final response = await httpClient.post(url, headers: headers);
      return response;
    } on DioException catch (e) {
      final codeString = e.response?.data?['code']?.toString() ?? '0';
      throw CustomAuthException(int.tryParse(codeString) ?? 0);
    } catch (e) {
      throw Exception('Error during custom login: ${e.toString()}');
    }
  }
}
