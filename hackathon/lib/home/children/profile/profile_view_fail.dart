import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/home/bloc/home_navigation_bloc.dart';
import 'package:hackathon/home/home.dart';

class ProfileViewFail extends StatelessWidget {
  const ProfileViewFail({super.key, required this.bottomKey});

  final Key bottomKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Не удалось получить данные о профиле'),
            const Text(
              'Проверьте подключение к интернету и попробуйте снова',
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
                onPressed: () {
                  context.read<HomeNavigationBloc>().add(const PageTapped(3));
                },
                child: const Text('Попробовать снова')),
          ],
        )),
      ),
      bottomNavigationBar: HomeBottomNavBar(key: bottomKey),
    );
  }
}
