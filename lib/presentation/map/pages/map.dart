import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:home_shield/core/routing/app_router.dart';
import 'package:home_shield/core/styles/app_values.dart';
import 'package:home_shield/data/map/models/location_info_model.dart';
import 'package:home_shield/presentation/map/cubit/map_cubit.dart';
import 'package:home_shield/presentation/map/widgets/organization_popup.dart';
import 'package:home_shield/presentation/map/widgets/user_popup.dart';
import 'package:home_shield/presentation/widgets/snack_bar.dart';
import 'package:home_shield/res/assets_res.dart';

// import 'package:google_maps_yt/consts.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Location _locationController = Location();
  BitmapDescriptor? _customIcon;

  late final defaultMarkers = {
    Marker(
        markerId: const MarkerId("_sourceLocation"),
        icon: BitmapDescriptor.defaultMarker,
        position: _mySchool,
        infoWindow: const InfoWindow(
          title: 'My School', // Tiêu đề của nhãn
          snippet: 'Trường ĐH CNTT và TT Việt Hàn', // Mô tả phụ
        ),
        onTap: () => _onMarkerTapped(
            organizationName: 'My school', phoneNumber: "0947 899 389")),
    Marker(
        markerId: const MarkerId("_police"),
        icon: BitmapDescriptor.defaultMarker,
        position: _police,
        infoWindow: const InfoWindow(
          title: 'Công an Phường Hoà Quý', // Tiêu đề của nhãn
          // snippet: 'Trường ĐH CNTT và TT Việt Hàn', // Mô tả phụ
        ),
        onTap: () => _onMarkerTapped(
            organizationName: 'Công an Phường Hoà Quý',
            phoneNumber: "0947 899 389")),
  };

  late final Set<Marker> _markers = <Marker>{};
  late Set<Marker> _friendsMarker = <Marker>{};

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  static const LatLng _mySchool = LatLng(15.97548334897396, 108.25291027532116);
  static const LatLng _police = LatLng(15.985805915717977, 108.24078619046364);

  late StreamSubscription<LocationData> _locationSubscription;

  LatLng? _currentP;

  bool isShowPopup = false;
  LocationInfoModel? locationInfoPopup;
  String? phoneNumberPopup;
  String? organizationNamePopup;

  @override
  void initState() {
    super.initState();
    _loadCustomIcon();
    context.read<MapCubit>().getFriendLocations();
    _markers.addAll(defaultMarkers);
    getLocationUpdates().then(
      (_) {
        if (_currentP != null) {
          _cameraToPosition(_currentP!);
        }
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

  void _onMarkerTapped(
      {LocationInfoModel? locationInfo,
      String? phoneNumber,
      String? organizationName}) {
    setState(() {
      isShowPopup = true;
      locationInfoPopup = locationInfo;
      phoneNumberPopup = phoneNumber;
      organizationNamePopup = organizationName;
    });
  }

  _mapBody() {
    var currentLocationMarker = Marker(
        markerId: const MarkerId("_currentLocation"),
        icon: _customIcon ??
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: _currentP ?? _mySchool,
        infoWindow: const InfoWindow(
          title: 'My location', // Tiêu đề của nhãn
          // snippet: '', // Mô tả phụ
        ));
    // return Placeholder();
    return BlocListener<MapCubit, MapState>(
      listener: (context, state) {
        if (state is ShowFriendLocation) {
          _friendsMarker = state.locationInfos
              .map((locationInfo) => Marker(
                    markerId: MarkerId(locationInfo.userId!),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueAzure),
                    position: LatLng(locationInfo.location!.latitude,
                        locationInfo.location!.longitude),
                    infoWindow: InfoWindow(
                      title: locationInfo.userName, // Tiêu đề của nhãn
                      // snippet: 'Trường ĐH CNTT và TT Việt Hàn', // Mô tả phụ
                    ),
                    onTap: () => _onMarkerTapped(locationInfo: locationInfo),
                  ))
              .toSet();
          setState(() {});
        }
      },
      child: Stack(
        children: [
          GoogleMap(
            onMapCreated: ((GoogleMapController controller) =>
                _mapController.complete(controller)),
            initialCameraPosition: const CameraPosition(
              target: _mySchool,
              zoom: 13,
            ),
            markers: {..._markers, ..._friendsMarker, currentLocationMarker},
            // polylines: Set<Polyline>.of(polylines.values),
          ),
          if (isShowPopup)
            Positioned(
              top: 50,
              // width: MediaQuery.of(context).size.width * 0.8,
              left: 20,
              right: 20,
              child: _buildPopup(),
            ),
        ],
      ),
    );
  }

  _onClosePopup() {
    print("close ttab");
    setState(() {
      isShowPopup = false;
      locationInfoPopup = null;
      phoneNumberPopup = null;
      organizationNamePopup = null;
    });
  }

  _onCall() {
    callPhone(locationInfoPopup!.phoneNumber!);
  }

  _onCallOrgnization() {
    callPhone(phoneNumberPopup!);
  }

  _onMess() {}

  Widget _buildPopup() {
    if (locationInfoPopup != null) {
      return UserInfoCard(
        locationInfoModel: locationInfoPopup!,
        onCall: _onCall,
        onMess: _onMess,
        onClose: _onClosePopup,
      );
    }
    return OrganizationPopup(
      organizationName: organizationNamePopup!,
      phoneNumber: phoneNumberPopup,
      onClose: _onClosePopup,
      onCall: _onCallOrgnization,
    );
  }

  void callPhone(String phoneNumber) async {
    final Uri url = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      showSnackBar(
          context, 'Không thể mở ứng dụng gọi điện thoại với số $phoneNumber');
      // throw 'Không thể mở ứng dụng gọi điện thoại với số $phoneNumber';
    }
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

    _locationSubscription = _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentP =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);

          print(currentLocation);
          // _cameraToPosition(_currentP!);
        });
      }
    });
  }

  @override
  void dispose() {
    _locationController.onLocationChanged.drain();
    _locationSubscription.cancel();
    super.dispose();
  }
}
