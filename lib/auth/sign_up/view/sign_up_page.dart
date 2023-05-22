import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/auth/sign_up/sign_up.dart';
import 'package:hackathon/gen/colors.gen.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.backgroundOrange,
      appBar: AppBar(title: const Text('Регистрация')),
      body: BlocProvider<SignUpCubit>(
        create: (_) => SignUpCubit(context.read<AuthenticationRepository>()),
        child: const SignUpForm(),
      ),
    );
  }
}
