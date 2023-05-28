import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon/auth/login/login.dart';
import 'package:hackathon/auth/sign_up/sign_up.dart';
import 'package:hackathon/gen/assets.gen.dart';
import 'package:hackathon/utils/route_transitions.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Ошибка авторизации'),
              ),
            );
        } else if (state.status.isSuccess) {
          Navigator.of(context).pop();
        }
      },
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: height * 0.05),
              Assets.icons.logoName.svg(width: width * 0.4),
              SizedBox(height: height * 0.05),
              SizedBox(
                height: height * 0.5,
                width: width * 0.9,
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(width * 0.05, height * 0.05,
                        width * 0.05, height * 0.05),
                    child: OverflowBox(
                      maxHeight: height * 0.4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _EmailInput(),
                          SizedBox(height: height * 0.02),
                          _PasswordInput(),
                          SizedBox(height: height * 0.05),
                          _LoginButton(),
                          SizedBox(height: height * 0.05),
                          const _ForgotPasswordButton()
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.05),
              const _SignUpButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return TextButton(
      onPressed: () =>
          Navigator.of(context).push<void>(createRoute(const SignUpPage())),
      style: TextButton.styleFrom(fixedSize: Size(width * 0.9, height * 0.05)),
      child: const Text('Зарегистрироваться'),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_emailInput_textField'),
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(
                width * 0.05, height * 0.02, width * 0.05, height * 0.02),
            labelText: 'Телефон / Email / СНИЛС',
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
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginCubit>().passwordChanged(password),
          obscureText: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(
                width * 0.05, height * 0.02, width * 0.05, height * 0.02),
            labelText: 'Пароль',
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(width * 0.7, height * 0.07),
                ),
                onPressed: state.isValid
                    ? () => context.read<LoginCubit>().logInWithCredentials()
                    : () {},
                child: Text(
                  'Войти',
                  style: GoogleFonts.inter()
                      .copyWith(color: Colors.white, fontSize: 16),
                ),
              );
      },
    );
  }
}

class _ForgotPasswordButton extends StatelessWidget {
  const _ForgotPasswordButton();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return TextButton(
      onPressed: () {}, //TODO: Восстановление пароля
      style: TextButton.styleFrom(fixedSize: Size(width * 0.7, height * 0.05)),
      child: const Text('Не удается войти?'),
    );
  }
}
