import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'i_storage_repository.dart';

class SecureStorageRepository extends IStorageRepository {
  final FlutterSecureStorage storage;

  SecureStorageRepository() : storage = FlutterSecureStorage();

  @override
  Future<String?> read(String key) async {
    return await storage.read(key: key);
  }

  @override
  Future<void> write(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  @override
  Future<void> delete(String key) async {
    await storage.delete(key: key);
  }

  @override
  Future<void> deleteAll() async{
    await storage.deleteAll();
  }
}
