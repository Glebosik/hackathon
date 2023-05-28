import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hackathon/gen/assets.gen.dart';
import 'package:hackathon/gen/colors.gen.dart';
import 'package:hackathon/home/children/chat/bloc/chat_bloc.dart';
import 'package:hackathon/home/children/chat/bloc/message.dart';
import 'package:hackathon/text_styles.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ChatCommandPanel extends StatefulWidget {
  const ChatCommandPanel({
    super.key,
    required TextEditingController controller,
  }) : _controller = controller;

  final TextEditingController _controller;

  @override
  State<ChatCommandPanel> createState() => _ChatCommandPanelState();
}

class _ChatCommandPanelState extends State<ChatCommandPanel> {
  final SpeechToText _speechToText = SpeechToText();
  String _lastWords = '';
  bool isActions = false;
  bool isTyping = false;
  bool isRecordingEnabled = false;
  bool isRecording = false;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    // ignore: unused_local_variable
    Map<Permission, PermissionStatus> statuses = await [
      Permission.microphone,
      Permission.bluetooth,
    ].request();
    if (await Permission.microphone.isGranted &&
        await Permission.bluetooth.isGranted) {
      isRecordingEnabled = await _speechToText.initialize();
      if (!mounted) return;
      setState(() {});
    }
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    if (!mounted) return;
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    if (!mounted) return;
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      widget._controller.text = _lastWords;
      widget._controller.selection =
          TextSelection.collapsed(offset: _lastWords.length);
      if (result.finalResult) {
        isRecording = false;
        if (widget._controller.text.isNotEmpty) {
          isTyping = true;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final chatBloc = context.read<MyChatBloc>();
    return SizedBox(
      width: width,
      child: Card(
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              iconSize: width * 0.13,
              splashRadius: 20,
              onPressed: () {},
              icon: Assets.icons.chatActions.svg(height: width * 0.13),
            ),
            SizedBox(
              width: width * 0.6,
              child: TextField(
                textCapitalization: TextCapitalization.sentences,
                controller: widget._controller,
                onChanged: (value) {
                  value.isEmpty
                      ? setState(() {
                          isTyping = false;
                        })
                      : setState(() {
                          isTyping = true;
                        });
                },
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelStyle: TextStyles.black14.copyWith(color: Colors.grey),
                  labelText: 'Сообщение',
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(width * 0.05,
                      height * 0.015, width * 0.05, height * 0.015),
                ),
              ),
            ),
            isTyping
                ? IconButton(
                    iconSize: width * 0.13,
                    splashRadius: 20,
                    onPressed: () {
                      chatBloc.add(ChatMessageSend(Message(
                          text: widget._controller.text,
                          timestamp: DateTime.now(),
                          isUser: true)));
                      widget._controller.clear();
                      isTyping = false;
                    },
                    icon: Assets.icons.sendMessage.svg(height: width * 0.13),
                  )
                : isRecording
                    ? IconButton(
                        iconSize: width * 0.13,
                        splashRadius: 20,
                        onPressed: () {
                          setState(() {
                            _stopListening();
                            isRecording = false;
                            if (widget._controller.text.isNotEmpty) {
                              isTyping = true;
                            }
                          });
                        },
                        icon: SpinKitWave(
                          itemCount: 7,
                          color: ColorName.hyperlinkOrange,
                          size: width * 0.1,
                        ),
                      )
                    : IconButton(
                        iconSize: width * 0.13,
                        splashRadius: 20,
                        onPressed: () {
                          setState(() {
                            _startListening();
                            isRecording = true;
                          });
                        },
                        icon: Assets.icons.recordMessage
                            .svg(height: width * 0.13),
                      ),
          ],
        ),
      ),
    );
  }
}
