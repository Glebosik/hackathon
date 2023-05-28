import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authenticationRepository) : super(const SignUpState());

  final AuthenticationRepository _authenticationRepository;

  void firstNameChanged(String value) {
    final firstName = Name.dirty(value);
    emit(
      state.copyWith(
        firstName: firstName,
        isValid: Formz.validate([
          firstName,
          state.secondName,
          state.email,
          state.password,
          state.confirmedPassword,
          state.question,
          state.answer
        ]),
      ),
    );
  }

  void secondNameChanged(String value) {
    final secondName = Name.dirty(value);
    emit(
      state.copyWith(
        secondName: secondName,
        isValid: Formz.validate([
          state.firstName,
          secondName,
          state.email,
          state.password,
          state.confirmedPassword,
          state.question,
          state.answer
        ]),
      ),
    );
  }

  void thirdNameChanged(String value) {
    final thirdName = Name.dirty(value);
    emit(
      state.copyWith(
        thirdName: thirdName,
        isValid: Formz.validate([
          state.firstName,
          state.secondName,
          thirdName,
          state.email,
          state.password,
          state.confirmedPassword,
          state.question,
          state.answer
        ]),
      ),
    );
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([
          email,
          state.firstName,
          state.secondName,
          state.password,
          state.confirmedPassword,
          state.question,
          state.answer
        ]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final confirmedPassword = ConfirmedPassword.dirty(
      password: password.value,
      value: state.confirmedPassword.value,
    );
    emit(
      state.copyWith(
        password: password,
        confirmedPassword: confirmedPassword,
        isValid: Formz.validate([
          state.email,
          state.firstName,
          state.secondName,
          password,
          confirmedPassword,
          state.question,
          state.answer
        ]),
      ),
    );
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );
    emit(
      state.copyWith(
        confirmedPassword: confirmedPassword,
        isValid: Formz.validate([
          state.email,
          state.firstName,
          state.secondName,
          state.password,
          confirmedPassword,
          state.question,
          state.answer
        ]),
      ),
    );
  }

  void questionChanged(String value) {
    final question = Question.dirty(value);
    emit(
      state.copyWith(
        question: question,
        isValid: Formz.validate([
          state.email,
          state.firstName,
          state.secondName,
          state.password,
          state.confirmedPassword,
          question,
          state.answer
        ]),
      ),
    );
  }

  void answerChanged(String value) {
    final answer = Answer.dirty(value);
    emit(
      state.copyWith(
        answer: answer,
        isValid: Formz.validate([
          state.email,
          state.firstName,
          state.secondName,
          state.password,
          state.confirmedPassword,
          state.question,
          answer
        ]),
      ),
    );
  }

  void checkBoxChanged(bool check) {
    emit(
      state.copyWith(
        check: check,
        isValid: Formz.validate([
          state.email,
          state.firstName,
          state.secondName,
          state.password,
          state.confirmedPassword,
          state.question,
          state.answer
        ]),
      ),
    );
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.isValid || !state.check) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      final uid = await _authenticationRepository.signUp(
        email: state.email.value,
        password: state.password.value,
      );
      FirebaseFirestore.instance.collection('users/').doc(uid).set({
        'email': state.email.value,
        'phoneNumber': '',
        'firstName': state.firstName.value,
        'secondName': state.secondName.value,
        'thirdName': state.thirdName?.value,
        'question': state.answer.value,
        'answer': state.answer.value,
        'approved': true,
        'updatedAt': DateTime.now(),
      });
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzSubmissionStatus.failure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
