part of 'sign_up_cubit.dart';

enum ConfirmPasswordValidationError { invalid }

final class SignUpState extends Equatable {
  const SignUpState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.question = const Question.pure(),
    this.answer = const Answer.pure(),
    this.firstName = const Name.pure(),
    this.secondName = const Name.pure(),
    this.thirdName,
    this.check = false,
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
  });

  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final Question question;
  final Answer answer;
  final Name firstName;
  final Name secondName;
  final Name? thirdName;
  final bool check;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        firstName,
        secondName,
        thirdName,
        email,
        password,
        confirmedPassword,
        question,
        answer,
        check,
        status,
        isValid,
        errorMessage,
      ];

  SignUpState copyWith({
    Email? email,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    Question? question,
    Answer? answer,
    Name? firstName,
    Name? secondName,
    Name? thirdName,
    bool? check,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      firstName: firstName ?? this.firstName,
      secondName: secondName ?? this.secondName,
      thirdName: thirdName ?? this.thirdName,
      check: check ?? this.check,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
