import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/gen/assets.gen.dart';
import 'package:hackathon/home/bloc/home_navigation_bloc.dart';
import 'package:hackathon/home/children/chat/bloc/chat_bloc.dart';
import 'package:hackathon/home/children/chat/widgets/chat_command_panel_placeholder.dart';
import 'package:hackathon/home/children/chat/widgets/widgets.dart';
import 'package:hackathon/text_styles.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key, required this.bottomKey});

  final Key bottomKey;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.zero,
          splashRadius: 24,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            context.read<HomeNavigationBloc>().add(const PageTapped(0));
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Assets.icons.botLogo.svg(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Константин',
                  style: TextStyles.black16,
                ),
                Text(
                  'Ваш личный ассистент',
                  style: TextStyles.black14.copyWith(color: Colors.grey),
                ),
              ],
            ),
            IconButton(
              splashRadius: 24,
              onPressed: () {},
              icon: const Icon(Icons.search),
            )
          ],
        ),
      ),
      body: BlocBuilder<MyChatBloc, MyChatState>(
        builder: (context, state) {
          if (state is ChatInitial) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 16),
                      Text(
                        'Константин готовится ответить на ваши вопросы',
                        textAlign: TextAlign.center,
                        style: TextStyles.black16.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                ChatCommandPanel(
                  controller: _controller,
                ),
              ],
            );
          } else if (state is ChatInitialized) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        'Константин готов ответить на ваши вопросы',
                        textAlign: TextAlign.center,
                        style: TextStyles.black16.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                ChatCommandPanel(
                  controller: _controller,
                ),
              ],
            );
          } else if (state is ChatInitializationFailed) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        'Не удалось связаться с Константином :(',
                        textAlign: TextAlign.center,
                        style: TextStyles.black16.copyWith(color: Colors.grey),
                      ),
                      Text(
                        'Проверьте подключение к интернету',
                        textAlign: TextAlign.center,
                        style: TextStyles.black12.copyWith(color: Colors.grey),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            context.read<MyChatBloc>().add(ChatInit());
                          },
                          child: const Text('Повторить попытку'))
                    ],
                  ),
                ),
                const Spacer(),
                const ChatCommandPanelPlaceholder(
                  textFieldLabel: 'Сообщение',
                ),
              ],
            );
          } else if (state is ChatMessageSent) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ChatBody(
                  messages: state.messages,
                ),
                const ChatCommandPanelPlaceholder(
                  textFieldLabel: 'Сообщение',
                ),
              ],
            );
          } else if (state is ChatMessageReceived) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ChatBody(messages: state.messages),
                ChatCommandPanel(
                  controller: _controller,
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
