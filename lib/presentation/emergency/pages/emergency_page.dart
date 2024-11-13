import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:home_shield/core/routing/app_router.dart';
import 'package:home_shield/presentation/emergency/cubit/emergency_cubit.dart';
import 'package:home_shield/presentation/widgets/snack_bar.dart';

class EmergencyPage extends StatefulWidget {
  const EmergencyPage({super.key});

  @override
  State<EmergencyPage> createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> {
  @override
  Future<void> initState() async {
    super.initState();
    _sendLocation();
  }

  _sendLocation() async {
    var location = await getCurrentLocation();

    if (location != null) {
      context
          .read<EmergencyCubit>()
          .sendLocation(location.latitude, location.longitude);
    } else {
      showSnackBar(context, "Cannot get location! Try again later.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  _body() {
    return BlocBuilder<EmergencyCubit, EmergencyState>(
      builder: (context, state) {
        if (state is SendLocationError) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Send locaion error"),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _sendLocation, child: Text("Try again"))
            ],
          );
        }

        if (state is SendLocationSuccess) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Send locaion success"),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: Text("Go back"))
            ],
          );
        }

        return const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Future<LatLng?> getCurrentLocation() async {
    // Kiểm tra quyền truy cập vị trí
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse) {
        return null; // Nếu quyền bị từ chối
      }
    }

    // Kiểm tra dịch vụ vị trí
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null; // Nếu dịch vụ vị trí không được bật
    }

    // Lấy vị trí hiện tại
    Position position = await Geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.best));

    // Trả về LatLng nếu có vị trí hợp lệ
    return LatLng(position.latitude, position.longitude);
  }
}
