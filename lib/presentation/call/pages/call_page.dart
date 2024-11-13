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
  late Room _room;
  RemoteVideoTrack? _localVideoTrack;

  @override
  void initState() {
    super.initState();
    _call();
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

  showVideo() {
    try {
      setState(() {
        // _localVideoTrack =
        //     _room.localParticipant?.videoTrackPublications.last.track;
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

    _room = Room();
    var url = "wss://my-app-f62a0jdr.livekit.cloud";
    // var token =
    //     "eyJhbGciOiJIUzI1NiJ9.eyJ2aWRlbyI6eyJyb29tSm9pbiI6dHJ1ZSwicm9vbSI6InJvb20xIn0sImlzcyI6IkFQSTU1TXk1eEF6c3NTbSIsImV4cCI6MTczMTQwOTY0NSwibmJmIjowLCJzdWIiOiJxdWlja3N0YXJ0LXVzZXJuYW1lMSJ9.Bf64ZnubsUcqyvxfDqf2BhICyIr6m4SQ0TyeT_BH3dA";
    var token =
        "eyJhbGciOiJIUzI1NiJ9.eyJ2aWRlbyI6eyJyb29tSm9pbiI6dHJ1ZSwicm9vbSI6InJvb20xIn0sImlzcyI6IkFQSTU1TXk1eEF6c3NTbSIsImV4cCI6MTczMTQwOTQ5MSwibmJmIjowLCJzdWIiOiJxdWlja3N0YXJ0LXVzZXJuYW1lIn0.3lIxi5RJ3m2-_o1s6sxTi5ZdU1Yk5dlK4vU73J3z4t4";

    await _room.connect(url, token);
    try {
      // video will fail when running in ios simulator
      Timer(const Duration(seconds: 3), () {
        showVideo();
        print("_room: ${_room.localParticipant}");
      });
    } catch (error) {
      print('Could not show video, error: $error');
    }

    await _room.localParticipant?.setMicrophoneEnabled(true);
    await _room.localParticipant?.setCameraEnabled(true);
  }

  @override
  void dispose() {
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
            : CircularProgressIndicator(), // Hiển thị tiến trình khi chưa có video
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
