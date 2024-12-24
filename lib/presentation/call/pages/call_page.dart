import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_shield/core/routing/app_router.dart';
import 'package:home_shield/res/assets_res.dart';
import 'package:livekit_client/livekit_client.dart';

class CallPage extends StatefulWidget {
  const CallPage({super.key});

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  late final Room _room = Room();
  RemoteVideoTrack? _localVideoTrack;
  late final EventsListener<RoomEvent> _listener = _room.createListener();
  late RemoteParticipant _remoteParticipant;

  @override
  void initState() {
    super.initState();
    _call();

    _listener
      ..on<RoomDisconnectedEvent>((_) {
        print("Disconnect event $_");
      })
      ..on<ParticipantConnectedEvent>((e) {
        print("participant joined: ${e.participant.identity}");
        // showVideo();
        _remoteParticipant = e.participant;
        _remoteParticipant.addListener(_renderVideo);
      });
  }

  Future<LocalVideoTrack> createCameraTrack() async {
    // Tạo một LocalVideoTrack từ camera
    return await LocalVideoTrack.createCameraTrack();
  }

  Future<void> publishCameraTrack(Room room) async {
    try {
      // Tạo LocalVideoTrack từ camera
      LocalVideoTrack cameraTrack = await createCameraTrack();

      // Kiểm tra xem localParticipant có tồn tại
      final participant = room.localParticipant;
      if (participant != null) {
        // Phát video track của camera
        await participant.publishVideoTrack(cameraTrack);
        print("Đã phát video track thành công.");
      } else {
        print("localParticipant không tồn tại.");
      }
    } catch (e) {
      print("Lỗi khi phát video track: $e");
    }
  }

  _renderVideo() {
    print("Call render video");

    if (_remoteParticipant.hasVideo) {
      print("Par has video");

      setState(() {
        _localVideoTrack =
            _remoteParticipant.videoTrackPublications.first.track;
      });
    }
  }

  showVideo() {
    try {
      setState(() {
        // _localVideoTrack =
        //     _room.localParticipant?.videoTrackPublications.last.track;
        _room.remoteParticipants.values.first.addListener(_renderVideo);
        _localVideoTrack = _room.remoteParticipants.values
            .firstWhere((par) => par.hasVideo)
            .videoTrackPublications
            .first
            .track;
        print(
            "Size of track: ${_room.localParticipant?.videoTrackPublications.length}");
      });
    } catch (e) {
      print(e.toString());
    }
  }

  _call() async {
    const cameraOptions = CameraCaptureOptions(
      cameraPosition: CameraPosition.front, // Chọn camera trước
      maxFrameRate: 30, // Đặt tỷ lệ khung hình tối đa
    );
    const roomOptions = RoomOptions(
      adaptiveStream: true,
      dynacast: true,
      defaultCameraCaptureOptions: cameraOptions,
      // ... your room options
    );

    // _room = Room();
    var url = "wss://my-app-f62a0jdr.livekit.cloud";
    var token =
        "eyJhbGciOiJIUzI1NiJ9.eyJ2aWRlbyI6eyJyb29tSm9pbiI6dHJ1ZSwicm9vbSI6InJvb20xIn0sImlzcyI6IkFQSTU1TXk1eEF6c3NTbSIsImV4cCI6MTczNTExOTM2NSwibmJmIjowLCJzdWIiOiJxdWlja3N0YXJ0LXVzZXJuYW1lIn0.F0ADbs5nnsFSccLoTOm67E2OCXokWyxNWZsbbNpzunk";
    // var token =
    //     "eyJhbGciOiJIUzI1NiJ9.eyJ2aWRlbyI6eyJyb29tSm9pbiI6dHJ1ZSwicm9vbSI6InJvb20xIn0sImlzcyI6IkFQSTU1TXk1eEF6c3NTbSIsImV4cCI6MTczNTExOTQ5MiwibmJmIjowLCJzdWIiOiJxdWlja3N0YXJ0LXVzZXJuYW1lMSJ9.7HXs20gH5tyCcdYmFg2rWUiIf4R3gJv9td9zSLX1KS8";
    await _room.connect(url, token);

    publishCameraTrack(_room);
    await _room.localParticipant?.setMicrophoneEnabled(true);
    await _room.localParticipant?.setCameraEnabled(true);

    var participants = _room.remoteParticipants.values;
    if (participants.isNotEmpty) {
      _remoteParticipant = participants.first;
      _remoteParticipant.addListener(_renderVideo);
    }
  }

  @override
  void dispose() {
    _listener.dispose();
    _room.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Video Call")),
      body: Center(
        child: _localVideoTrack != null
            ? VideoTrackRenderer(_localVideoTrack!)
            : const CircularProgressIndicator(), // Hiển thị tiến trình khi chưa có video
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _room.disconnect();
          context.pop();
        },
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: const Image(
            image: AssetImage(
          AssetsRes.HAND_OFF_ICON,
        )),
      ),
    );
  }
}
