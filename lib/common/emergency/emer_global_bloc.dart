import 'dart:async';
import 'dart:isolate';

import 'package:bloc/bloc.dart';
import 'package:home_shield/common/location/get_current_location.dart';
import 'package:home_shield/common/open_app/open_phone.dart';
import 'package:home_shield/domain/emergency/use_case/send_location.dart';
import 'package:home_shield/domain/emergency/use_case_params/send_loaction_params.dart';
import 'package:home_shield/service_locator.dart';
import 'package:meta/meta.dart';

part 'emer_global_event.dart';

part 'emer_global_state.dart';

class EmerGlobalBloc extends Bloc<EmerGlobalEvent, EmerGlobalState> {
  EmerGlobalBloc() : super(EmerGlobalInitial()) {
    on<EmerGlobalEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ShakeDetected>(_onShakeDetected);
  }

  Future<void> _onShakeDetected(ShakeDetected event, emit) async {
    // var future = _sendLocation(emit);
    // await future;

    callPhone("0915 941 874");
  }

  _sendLocation(emit) async {
    emit(EmerGettingLocation());

    var location = await getCurrentLocation();
    if (location == null) {
      emit(SendLocaError("Can not get current location"));
      return;
    }
    double lat = location.latitude;
    double lng = location.longitude;
    // emit(EmergencyLoading());

    var useCase = sl<SendLocationUseCase>();
    var params = SendLocationParams(lat: lat, lng: lng);

    var result = await useCase.call(params: params);

    result.fold((e) {
      emit(SendLocaError(e.toString()));
    }, (data) {
      emit(SendLocaSuccess());
    });
  }
}
