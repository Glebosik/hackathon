import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/gen/colors.gen.dart';
import 'package:hackathon/home/children/conference/bloc/conference_bloc.dart';
import 'package:hackathon/home/children/conference/conference_view.dart';

class ConferencePage extends StatelessWidget {
  const ConferencePage({super.key, required this.uid});

  final int uid;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConferenceBloc, ConferenceState>(
      builder: (context, state) {
        if (state is ConferenceLoading) {
          return Scaffold(
            appBar: AppBar(title: const Text('Консультирование')),
            body: const Center(
                child: CircularProgressIndicator(
              color: ColorName.orange,
            )),
          );
        } else if (state is ConferenceFail) {
          return Scaffold(
            appBar: AppBar(title: const Text('Консультирование')),
            body: Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                    'Не удалось получить данные о ваших записях на консультирования'),
                const Text(
                    'Проверьте подключение к интернету и попробуйте снова'),
                ElevatedButton(
                    onPressed: () {
                      context.read<ConferenceBloc>().add(ConferenceStart());
                    },
                    child: const Text('Попробовать снова')),
              ],
            )),
          );
        } else if (state is ConferenceReady) {
          return ConferenceView(
            appId: state.appId,
            token: state.token,
            channel: state.channel,
            uid: uid,
          );
        }
        return const Text('Упс... Что-то пошло не так');
      },
    );
  }
}
