import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:minhaserigrafia/infra/http/dio/dio_http_client.dart';
import 'package:minhaserigrafia/infra/storage/secure_storage_repository.dart';
import 'package:minhaserigrafia/modules/core/service/current_auth_user_service.dart';

class CoreModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(SecureStorageRepository.new);
    i.addLazySingleton(Dio.new);
    i.addLazySingleton(DioHttpClient.new);
    i.addSingleton(CurrentAuthUserService.new);
    i.addSingleton(FlutterSecureStorage.new);
  }
}
