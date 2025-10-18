import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:minhaserigrafia/shared/model/user_type.dart';

class AuthUserStorageKeys {
  static const String userIdKey = 'authIdKey';
  static const String tenantKey = 'tenantKey';
  static const String userTypeKey = 'userTypeKey';
  static const String isFirstAccessKey = 'isFirstAccessKey';
  static const String firebaseUserIdKey = 'refreshTokenKey';

  static List<String> get allKeys => [
    userIdKey,
    tenantKey,
    userTypeKey,
    isFirstAccessKey,
    firebaseUserIdKey,
  ];
}

class CurrentAuthUserService {
  final FlutterSecureStorage _storage;

  CurrentAuthUserService(this._storage);

  int? _userId;
  int? _tenant;
  String? _userType;
  String? _firebaseUserId;
  bool? _isFirstAccess;
  String? _firebaseIdToken;

  bool get isFirstAccess => _isFirstAccess ?? false;

  String get firebaseIdToken => 'Bearer $_firebaseIdToken';

  UserType get userType => UserType.fromString(_userType);

  void setFirebaseIdToken(String token) => _firebaseIdToken = token;

  Future<void> init() async {
    String? userIdStr = await _storage.read(key: AuthUserStorageKeys.userIdKey);
    String? tenantStr = await _storage.read(key: AuthUserStorageKeys.tenantKey);
    _userType = await _storage.read(key: AuthUserStorageKeys.userTypeKey);
    _firebaseUserId = await _storage.read(
      key: AuthUserStorageKeys.firebaseUserIdKey,
    );
    final isFirstAccessStr = await _storage.read(
      key: AuthUserStorageKeys.isFirstAccessKey,
    );

    _userId = userIdStr != null ? int.tryParse(userIdStr) : null;
    _tenant = tenantStr != null ? int.tryParse(tenantStr) : null;
    _isFirstAccess = isFirstAccessStr == 'true';
    _isFirstAccess = isFirstAccessStr == 'true';
  }

  void setCurrentUserFromJson(Map<String, dynamic> json) {
    _setCurrentUser(
      userId: json['user_id'] as int,
      tenant: json['tenant'] as int,
      userType: json['user_type'] as String,
      firebaseUserId: json['firebase_user_id'] as String,
      isFirstAccess: json['is_first_access'] as bool,
    );
  }

  void _setCurrentUser({
    required int userId,
    required int tenant,
    required String userType,
    required String firebaseUserId,
    required bool isFirstAccess,
  }) async {
    _userId = userId;
    _tenant = tenant;
    _userType = userType;
    _firebaseUserId = firebaseUserId;
    _isFirstAccess = isFirstAccess;

    await _writeInSecureStorage();
  }

  Future<void> _writeInSecureStorage() async {
    await _storage.write(
      key: AuthUserStorageKeys.userIdKey,
      value: _userId.toString(),
    );
    await _storage.write(
      key: AuthUserStorageKeys.tenantKey,
      value: _tenant.toString(),
    );
    await _storage.write(
      key: AuthUserStorageKeys.userTypeKey,
      value: _userType,
    );
    await _storage.write(
      key: AuthUserStorageKeys.firebaseUserIdKey,
      value: _firebaseUserId,
    );
    await _storage.write(
      key: AuthUserStorageKeys.isFirstAccessKey,
      value: _isFirstAccess.toString(),
    );
  }

  bool isPresent() {
    return _userId != null &&
        _tenant != null &&
        _userType != null &&
        _firebaseUserId != null &&
        _isFirstAccess != null;
  }

  void clearCurrentUser() {
    _userId = null;
    _tenant = null;
    _userType = null;
    _firebaseUserId = null;
    _isFirstAccess = null;

    for (final key in AuthUserStorageKeys.allKeys) {
      _storage.delete(key: key);
    }
  }
}
