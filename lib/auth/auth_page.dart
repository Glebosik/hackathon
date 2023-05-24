import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon/auth/login/login.dart';
import 'package:hackathon/auth/sign_up/sign_up.dart';
import 'package:hackathon/gen/assets.gen.dart';
import 'package:hackathon/utils/route_transitions.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: AuthPage());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              Assets.icons.moscow.svg(),
              const Spacer(),
              Assets.icons.logoName.svg(),
              const Spacer(),
              const _LoginButton(),
              SizedBox(
                height: height * 0.02,
              ),
              const _ForgotPasswordButton(),
              const Spacer(),
              const Text('Впервые у нас?'),
              const _SignUpButton(),
              SizedBox(
                height: height * 0.05,
              ),
            ],
          ),
        ),
      ),
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
      style: TextButton.styleFrom(fixedSize: Size(width * 0.9, height * 0.05)),
      child: const Text('Восстановить пароль'),
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
          Navigator.of(context).push(createRoute(const SignUpPage())),
      style: TextButton.styleFrom(fixedSize: Size(width * 0.9, height * 0.05)),
      child: const Text('Зарегистрироваться'),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: () =>
          Navigator.of(context).push<void>(createRoute(const LoginPage())),
      style:
          ElevatedButton.styleFrom(fixedSize: Size(width * 0.9, height * 0.07)),
      child: Text(
        'Войти',
        style: GoogleFonts.inter().copyWith(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
