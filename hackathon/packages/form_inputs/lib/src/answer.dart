import 'package:formz/formz.dart';

/// Validation errors for the [Answer] [FormzInput].
enum AnswerValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Answer}
/// Form input for an Answer input.
/// {@endtemplate}
class Answer extends FormzInput<String, AnswerValidationError> {
  /// {@macro Answer}
  const Answer.pure() : super.pure('');

  /// {@macro Answer}
  const Answer.dirty([super.value = '']) : super.dirty();

  @override
  AnswerValidationError? validator(String? value) {
    return null;
  }
}
