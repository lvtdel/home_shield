import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:home_shield/core/routing/app_router.dart';
import 'package:home_shield/core/styles/app_values.dart';
import 'package:home_shield/res/assets_res.dart';

// import 'package:google_maps_yt/consts.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Location _locationController = Location();
  BitmapDescriptor? _customIcon;

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  static const LatLng _mySchool = LatLng(15.97548334897396, 108.25291027532116);
  static const LatLng _friend1 = LatLng(15.981817, 108.255601);
  static const LatLng _police = LatLng(15.985805915717977, 108.24078619046364);

  // static const LatLng _pApplePark = LatLng(37.3346, -122.0090);
  LatLng? _currentP;

  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    _loadCustomIcon();
    getLocationUpdates().then(
      (_) {
        if (_currentP != null) {
          _cameraToPosition(_currentP!);
        }

        // setState(() {
        //
        // });

        // getPolylinePoints().then((coordinates) => {
        //   generatePolyLineFromPoints(coordinates),
        // }),
      },
    );
  }

  Future<void> _loadCustomIcon() async {
    final icon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(50, 50)),
      AssetsRes.LOCATION_ICON,
    );
    // _customIcon = icon;
    setState(() {
      _customIcon = icon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _mapBody(),
      floatingActionButton: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Positioned(
            bottom: 100.0,
            right: 0,
            child: FloatingActionButton(
              onPressed: () {
                _cameraToMyPosition();
              },
              child: Image.asset(AssetsRes.REDIRECT_MY_LOCATION_ICON),
            ),
          ),
          // Positioned(
          //   top: 60,
          //   right: AppPadding.p10,
          //   child: FloatingActionButton(
          //     onPressed: () {
          //       context.pop();
          //       print("pop");
          //     },
          //     child: Image.asset(AssetsRes.CLOSE_ICON),
          //   ),
          // ),
        ],
      ),
    );
  }

  _mapBody() {
    // return Placeholder();
    return GoogleMap(
      onMapCreated: ((GoogleMapController controller) =>
          _mapController.complete(controller)),
      initialCameraPosition: const CameraPosition(
        target: _mySchool,
        zoom: 13,
      ),
      markers: {
        Marker(
            markerId: const MarkerId("_currentLocation"),
            icon: _customIcon ??
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            position: _currentP ?? _mySchool,
            infoWindow: InfoWindow(
              title: 'My location', // Tiêu đề của nhãn
              // snippet: '', // Mô tả phụ
            )),
        const Marker(
          markerId: MarkerId("_sourceLocation"),
          icon: BitmapDescriptor.defaultMarker,
          position: _mySchool,
          infoWindow: InfoWindow(
            title: 'My School', // Tiêu đề của nhãn
            snippet: 'Trường ĐH CNTT và TT Việt Hàn', // Mô tả phụ
          ),
        ),
        const Marker(
          markerId: MarkerId("_police"),
          icon: BitmapDescriptor.defaultMarker,
          position: _police,
          infoWindow: InfoWindow(
            title: 'Công an Phường Hoà Quý', // Tiêu đề của nhãn
            // snippet: 'Trường ĐH CNTT và TT Việt Hàn', // Mô tả phụ
          ),
        ),
        Marker(
          markerId: MarkerId("_friend1"),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          position: _friend1,
          infoWindow: InfoWindow(
            title: 'Minh Quang', // Tiêu đề của nhãn
            // snippet: 'Trường ĐH CNTT và TT Việt Hàn', // Mô tả phụ
          ),
        ),
      },
      polylines: Set<Polyline>.of(polylines.values),
    );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition newCameraPosition = CameraPosition(
      target: pos,
      zoom: 13,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(newCameraPosition),
    );
  }

  _cameraToMyPosition() {
    _cameraToPosition(_currentP!);
  }

  Future<void> getLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _locationController.serviceEnabled();
    if (serviceEnabled) {
      serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    permissionGranted = await _locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentP =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          // _cameraToPosition(_currentP!);
        });
      }
    });
  }

  // Future<List<LatLng>> getPolylinePoints() async {
  //   List<LatLng> polylineCoordinates = [];
  //   PolylinePoints polylinePoints = PolylinePoints();
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //     GOOGLE_MAPS_API_KEY,
  //     PointLatLng(_pGooglePlex.latitude, _pGooglePlex.longitude),
  //     PointLatLng(_pApplePark.latitude, _pApplePark.longitude),
  //     travelMode: TravelMode.driving,
  //   );
  //   if (result.points.isNotEmpty) {
  //     result.points.forEach((PointLatLng point) {
  //       polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //     });
  //   } else {
  //     print(result.errorMessage);
  //   }
  //   return polylineCoordinates;
  // }

  void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.black,
        points: polylineCoordinates,
        width: 8);
    setState(() {
      polylines[id] = polyline;
    });
  }

  @override
  void dispose() {
    _locationController.onLocationChanged.drain();
    super.dispose();
  }
}
