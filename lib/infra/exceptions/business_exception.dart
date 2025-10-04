abstract class BusinessException implements Exception {
  final int code;

  BusinessException(this.code);
}