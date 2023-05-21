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

  static final RegExp _nameRegExp = RegExp(
    r'^/[^a-zа-яё ]/iu',
  );

  @override
  NameValidationError? validator(String? value) {
    return _nameRegExp.hasMatch(value ?? '')
        ? null
        : NameValidationError.invalid;
  }
}
