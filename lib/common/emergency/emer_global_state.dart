part of 'emer_global_bloc.dart';

@immutable
sealed class EmerGlobalState {}

final class EmerGlobalInitial extends EmerGlobalState {}
final class EmerGettingLocation extends EmerGlobalState {}

final class SendLocaError extends EmerGlobalState {
  final String mess;

  SendLocaError(this.mess);
}

final class SendLocaSuccess extends EmerGlobalState{}