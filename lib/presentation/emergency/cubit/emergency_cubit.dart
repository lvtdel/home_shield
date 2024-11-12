import 'package:bloc/bloc.dart';
import 'package:home_shield/domain/emergency/use_case/send_location.dart';
import 'package:home_shield/domain/emergency/use_case_params/send_loaction_params.dart';
import 'package:home_shield/service_locator.dart';
import 'package:meta/meta.dart';

part 'emergency_state.dart';

class EmergencyCubit extends Cubit<EmergencyState> {
  EmergencyCubit() : super(EmergencyInitial());

  sendLocation(double lat, double lng) async {
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
