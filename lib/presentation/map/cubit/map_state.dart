part of 'map_cubit.dart';

@immutable
sealed class MapState {}

final class MapInitial extends MapState {}

final class MapLoading extends MapState {}

final class ShowFriendLocation extends MapState {
  final List<LocationInfoModel> locationInfos;

  ShowFriendLocation(this.locationInfos);
}

final class MapError extends MapState {
  final String mess;

  MapError(this.mess);
}