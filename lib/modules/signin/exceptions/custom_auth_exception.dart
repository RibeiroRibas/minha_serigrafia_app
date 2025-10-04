import 'package:minhaserigrafia/infra/exceptions/business_exception.dart';

class CustomAuthException extends BusinessException {
  CustomAuthException(super.code);
}
