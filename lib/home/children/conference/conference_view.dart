import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackathon/gen/colors.gen.dart';
import 'package:permission_handler/permission_handler.dart';

class ConferenceView extends StatefulWidget {
  const ConferenceView(
      {Key? key,
      required this.appId,
      required this.token,
      required this.channel,
      required this.uid})
      : super(key: key);

  final String appId;
  final String token;
  final String channel;
  final int uid;

  @override
  State<ConferenceView> createState() => _ConferenceViewState();
}

class _ConferenceViewState extends State<ConferenceView> {
  int? _remoteUid;
  bool isJoined = false,
      switchCamera = true,
      switchMicrophone = true,
      switchVideo = true;
  late RtcEngine _engine;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    await [Permission.microphone, Permission.camera].request();

    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(
      appId: widget.appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          setState(() {
            isJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();
    await _engine.startPreview();

    await _engine.joinChannel(
      token: widget.token,
      channelId: widget.channel,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  Future<void> _switchMicrophone() async {
    // await await _engine.muteLocalAudioStream(!openMicrophone);
    await _engine.enableLocalAudio(!switchMicrophone);
    setState(() {
      switchMicrophone = !switchMicrophone;
    });
  }

  Future<void> _switchCamera() async {
    await _engine.switchCamera();
    setState(() {
      switchCamera = !switchCamera;
    });
  }

  Future<void> _switchVideo() async {
    await _engine.enableLocalVideo(!switchVideo);
    setState(() {
      switchVideo = !switchVideo;
    });
  }

  Future<void> _leaveChannel() async {
    await _engine.leaveChannel();
  }

  Future<void> _dispose() async {
    await _engine.leaveChannel();
    await _engine.release();
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  // Create UI with local view and remote view
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: _remoteVideo(),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Card(
                    child: SizedBox(
                      width: height * 0.2,
                      height: height * 0.3,
                      child: Center(
                        child: isJoined
                            ? switchVideo
                                ? AgoraVideoView(
                                    controller: VideoViewController(
                                      rtcEngine: _engine,
                                      canvas: VideoCanvas(uid: 0),
                                    ),
                                  )
                                : Icon(Icons.videocam_off)
                            : CircularProgressIndicator(
                                color: widget.uid == 1
                                    ? ColorName.orange
                                    : ColorName.green,
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MaterialButton(
                        height: 50,
                        color: Colors.white,
                        onPressed: _switchCamera,
                        shape: const CircleBorder(),
                        child: const Icon(Icons.autorenew),
                      ),
                      MaterialButton(
                        height: 50,
                        color: Colors.white,
                        onPressed: _switchVideo,
                        shape: const CircleBorder(),
                        child: switchVideo
                            ? const Icon(Icons.videocam)
                            : const Icon(Icons.videocam_off),
                      ),
                      MaterialButton(
                        height: 50,
                        color: Colors.white,
                        onPressed: _switchMicrophone,
                        shape: const CircleBorder(),
                        child: switchMicrophone
                            ? const Icon(Icons.mic)
                            : const Icon(Icons.mic_off),
                      ),
                      MaterialButton(
                        height: 50,
                        color: Colors.red,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        shape: const CircleBorder(),
                        child: const Icon(
                          Icons.call_end_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  // Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: RtcConnection(channelId: widget.channel),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          widget.uid == 1
              ? 'Ожидайте подключения инспектора'
              : 'Ожидайте подключения консультируемого',
          textAlign: TextAlign.center,
        ),
      );
    }
  }
}
