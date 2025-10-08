import 'package:formz/formz.dart';

enum CellphoneValidationError { empty, invalid }

class Cellphone extends FormzInput<String, CellphoneValidationError> {
  const Cellphone.pure() : super.pure('');

  const Cellphone.dirty([super.value = '']) : super.dirty();

  static final RegExp _cellphoneRegExp = RegExp(
    r'^\(?\d{2}\)?[\s-]?\d{4,5}-?\d{4}$',
  );

  @override
  CellphoneValidationError? validator(String value) {
    if (value.isEmpty) {
      return CellphoneValidationError.empty;
    }
    if (!_cellphoneRegExp.hasMatch(value)) {
      return CellphoneValidationError.invalid;
    }
    return null;
  }
}
