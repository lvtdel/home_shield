import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
