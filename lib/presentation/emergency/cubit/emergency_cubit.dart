import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:home_shield/common/location/get_current_location.dart';
import 'package:home_shield/domain/emergency/use_case/send_location.dart';
import 'package:home_shield/domain/emergency/use_case_params/send_loaction_params.dart';
import 'package:home_shield/service_locator.dart';
import 'package:meta/meta.dart';

part 'emergency_state.dart';

class EmergencyCubit extends Cubit<EmergencyState> {
  EmergencyCubit() : super(EmergencyInitial());

  sendLocation() async {
    var location = await getCurrentLocation();
    if (location == null) {
      emit(SendLocationError("Can not get current location"));
      return;
    }
    double lat = location.latitude;
    double lng = location.longitude;
    emit(EmergencyLoading());

    var useCase = sl<SendLocationUseCase>();
    var params = SendLocationParams(lat: lat, lng: lng);

    var result = await useCase.call(params: params);

    result.fold((e) {
      emit(SendLocationError(e.toString()));
    }, (data) {
      emit(SendLocationSuccess());
    });
  }

}
