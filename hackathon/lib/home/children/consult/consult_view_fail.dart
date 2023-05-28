import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/home/bloc/home_navigation_bloc.dart';
import 'package:hackathon/home/home.dart';

class ConsultViewFail extends StatelessWidget {
  const ConsultViewFail({super.key, required this.bottomKey});

  final Key bottomKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Консультации'),
      ),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
              'Не удалось получить данные о ваших записях на консультирования'),
          const Text('Проверьте подключение к интернету и попробуйте снова'),
          ElevatedButton(
              onPressed: () {
                context.read<HomeNavigationBloc>().add(const PageTapped(2));
              },
              child: const Text('Попробовать снова')),
        ],
      )),
      bottomNavigationBar: HomeBottomNavBar(key: bottomKey),
    );
  }
}
