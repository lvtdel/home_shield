import 'package:bloc/bloc.dart';
import 'package:home_shield/data/map/models/location_info_model.dart';
import 'package:home_shield/data/map/repositories/map_repository.dart';
import 'package:home_shield/service_locator.dart';
import 'package:meta/meta.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial());

  getFriendLocations() async {
    var data = await sl<MapRepository>().getFriendLocations();

    data.fold((e){emit(MapError(e));}, (data){
      emit(ShowFriendLocation(data));
    });
  }
}
