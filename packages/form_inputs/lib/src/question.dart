import 'package:formz/formz.dart';

/// Validation errors for the [Question] [FormzInput].
enum QuestionValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template Question}
/// Form input for an Question input.
/// {@endtemplate}
class Question extends FormzInput<String, QuestionValidationError> {
  /// {@macro Question}
  const Question.pure() : super.pure('');

  /// {@macro Question}
  const Question.dirty([super.value = '']) : super.dirty();

  @override
  QuestionValidationError? validator(String? value) {
    return null;
  }
}
