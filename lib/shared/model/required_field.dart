import 'package:formz/formz.dart';

enum RequiredFieldValidationError { empty }

class RequiredField extends FormzInput<String, RequiredFieldValidationError> {
  const RequiredField.pure() : super.pure('');

  const RequiredField.dirty([super.value = '']) : super.dirty();

  @override
  RequiredFieldValidationError? validator(String value) {
    if (value.isEmpty) return RequiredFieldValidationError.empty;
    return null;
  }
}
