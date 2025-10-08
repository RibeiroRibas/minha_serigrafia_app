import 'package:minhaserigrafia/infra/exceptions/business_exception.dart';

class EmailInUseException extends BusinessException {
  EmailInUseException(super.code);
}
