import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/home/children/check_in/bloc/check_in_bloc.dart';
import 'package:hackathon/text_styles.dart';

class CheckInFail extends StatelessWidget {
  const CheckInFail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Запись на консультирование',
          style: TextStyles.black18bold,
        ),
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
                context.read<CheckInBloc>().add(CheckInFetchKno());
              },
              child: const Text('Попробовать снова')),
        ],
      )),
    );
  }
}
