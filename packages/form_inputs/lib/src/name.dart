import 'package:formz/formz.dart';

/// Validation errors for the [name] [FormzInput].
enum NameValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template name}
/// Form input for an name input.
/// {@endtemplate}
class Name extends FormzInput<String, NameValidationError> {
  /// {@macro name}
  const Name.pure() : super.pure('');

  /// {@macro name}
  const Name.dirty([super.value = '']) : super.dirty();

  // ignore: unused_field
  static final RegExp _nameRegExp = RegExp(r"^[a-zA-Zа-яА-Я]+");

  @override
  NameValidationError? validator(String? value) {
    return null; //TODO: Проверка имени
  }
}
