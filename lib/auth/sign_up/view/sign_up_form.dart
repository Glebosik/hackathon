import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon/auth/sign_up/sign_up.dart';
import 'package:hackathon/gen/assets.gen.dart';
import 'package:hackathon/gen/colors.gen.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          Navigator.of(context).pop();
        } else if (state.status.isFailure) {
          //TODO: Сделать нормальное сообщение при ошибке
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                  content:
                      Text(state.errorMessage ?? 'Ошибка при регистрации')),
            );
        }
      },
      child: SingleChildScrollView(
        child: Column(children: [
          SizedBox(height: height * 0.04),
          Assets.icons.moscowAccess.svg(width: width * 0.8),
          SizedBox(height: height * 0.04),
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.fromLTRB(
                width * 0.05, height * 0.03, width * 0.05, height * 0.03),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(children: [
              Text("Регистрация",
                  style: GoogleFonts.inter().copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: height * 0.04),
              Padding(
                padding: EdgeInsets.only(left: width * 0.05),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Личные данные',
                    style: GoogleFonts.inter().copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.04),
              _SecondNameInput(),
              SizedBox(height: height * 0.02),
              _FirstNameInput(),
              SizedBox(height: height * 0.02),
              _ThirdNameInput(),
              SizedBox(height: height * 0.04),
              Padding(
                padding: EdgeInsets.only(left: width * 0.05),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Контактная информация',
                    style: GoogleFonts.inter().copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: width * 0.04),
              Padding(
                padding:
                    EdgeInsets.only(left: width * 0.05, right: width * 0.05),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'На указанные номер мобильного телефона и адрес электронной почты будут отправлены коды подтверждения регистрации',
                    style: GoogleFonts.inter().copyWith(
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.04),
              _EmailInput(),
              SizedBox(height: height * 0.04),
              Padding(
                padding: EdgeInsets.only(left: width * 0.05),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Безопасность',
                    style: GoogleFonts.inter().copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: width * 0.04),
              Padding(
                padding:
                    EdgeInsets.only(left: width * 0.05, right: width * 0.05),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Придумайте пароль, контрольный вопрос и ответ на него для получения и восстановления доступа к личному кабинету',
                    style: GoogleFonts.inter().copyWith(
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.04),
              _PasswordInput(),
              SizedBox(height: height * 0.02),
              _ConfirmPasswordInput(),
              SizedBox(height: height * 0.02),
              _QuestionInput(),
              SizedBox(height: height * 0.02),
              _AnswerInput(),
              SizedBox(height: height * 0.04),
              const _CheckBox(),
              SizedBox(height: height * 0.04),
              _SignUpButton(),
            ]),
          )
        ]),
      ),
    );
  }
}

class _CheckBox extends StatefulWidget {
  const _CheckBox();

  @override
  State<_CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<_CheckBox> {
  bool check = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Checkbox(
          activeColor: ColorName.orange,
          value: check,
          onChanged: (bool? value) {
            setState(() {
              check = value!;
            });
            context.read<SignUpCubit>().checkBoxChanged(value!);
          },
        ),
        SizedBox(
          width: width * 0.75,
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                const TextSpan(text: 'Я принимаю условия '),
                TextSpan(
                  text:
                      'соглашения о пользовании информационными ресурсами системами и ресурсами города Москвы',
                  style: GoogleFonts.inter()
                      .copyWith(color: ColorName.hyperlinkOrange),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launchUrl(Uri.parse('https://www.mos.ru/legal/rules/'));
                    },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _FirstNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.firstName != current.firstName,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_firstNameInput_textField'),
          onChanged: (firstName) =>
              context.read<SignUpCubit>().firstNameChanged(firstName),
          decoration: InputDecoration(
            labelText: 'Имя',
            contentPadding: EdgeInsets.fromLTRB(
                width * 0.05, height * 0.02, width * 0.05, height * 0.02),
          ),
        );
      },
    );
  }
}

class _SecondNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_secondNameInput_textField'),
          onChanged: (secondName) =>
              context.read<SignUpCubit>().secondNameChanged(secondName),
          decoration: InputDecoration(
            labelText: 'Фамилия',
            contentPadding: EdgeInsets.fromLTRB(
                width * 0.05, height * 0.02, width * 0.05, height * 0.02),
          ),
        );
      },
    );
  }
}

class _ThirdNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_thirdNamePasswordInput_textField'),
          onChanged: (thirdName) =>
              context.read<SignUpCubit>().thirdNameChanged(thirdName),
          decoration: InputDecoration(
            labelText: 'Отчество',
            contentPadding: EdgeInsets.fromLTRB(
                width * 0.05, height * 0.02, width * 0.05, height * 0.02),
          ),
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_emailInput_textField'),
          onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Адрес электронной почты',
            errorText: state.email.displayError != null
                ? 'Некорректный адрес электронной почты'
                : null,
            contentPadding: EdgeInsets.fromLTRB(
                width * 0.05, height * 0.02, width * 0.05, height * 0.02),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<SignUpCubit>().passwordChanged(password),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Пароль',
            errorText: state.password.displayError != null
                ? 'Пароль должен содержать минимум 8 символов, включая одну цифру и букву'
                : null,
            errorMaxLines: 3,
            contentPadding: EdgeInsets.fromLTRB(
                width * 0.05, height * 0.02, width * 0.05, height * 0.02),
          ),
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_confirmedPasswordInput_textField'),
          onChanged: (confirmPassword) => context
              .read<SignUpCubit>()
              .confirmedPasswordChanged(confirmPassword),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Подтвердите пароль',
            errorText: state.confirmedPassword.displayError != null
                ? 'Пароли не совпадают'
                : null,
            contentPadding: EdgeInsets.fromLTRB(
                width * 0.05, height * 0.02, width * 0.05, height * 0.02),
          ),
        );
      },
    );
  }
}

class _QuestionInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_questionInput_textField'),
          onChanged: (question) =>
              context.read<SignUpCubit>().questionChanged(question),
          decoration: InputDecoration(
            labelText: 'Контрольный вопрос',
            errorText: state.question.displayError != null ? "Mda" : null,
            contentPadding: EdgeInsets.fromLTRB(
                width * 0.05, height * 0.02, width * 0.05, height * 0.02),
          ),
        );
      },
    );
  }
}

class _AnswerInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_AnswerInput_textField'),
          onChanged: (answer) =>
              context.read<SignUpCubit>().answerChanged(answer),
          decoration: InputDecoration(
            labelText: 'Ответ на контрольный вопрос',
            errorText: state.answer.displayError != null ? "Mda" : null,
            contentPadding: EdgeInsets.fromLTRB(
                width * 0.05, height * 0.02, width * 0.05, height * 0.02),
          ),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('signUpForm_continue_raisedButton'),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(width * 0.7, height * 0.06),
                  backgroundColor: state.isValid && state.check
                      ? ColorName.hyperlinkOrange
                      : Colors.grey,
                  splashFactory: state.isValid && state.check
                      ? InkRipple.splashFactory
                      : NoSplash.splashFactory,
                ),
                onPressed: state.isValid && state.check
                    ? () => context.read<SignUpCubit>().signUpFormSubmitted()
                    : () {},
                child: Text(
                  'Зарегистрироваться',
                  style: GoogleFonts.inter()
                      .copyWith(color: Colors.white, fontSize: 16),
                ),
              );
      },
    );
  }
}
