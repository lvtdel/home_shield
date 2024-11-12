part of 'emergency_cubit.dart';

@immutable
sealed class EmergencyState {}

final class EmergencyInitial extends EmergencyState {}

final class EmergencyLoading extends EmergencyState {}

final class SendLocationSuccess extends EmergencyState {}

final class SendLocationError extends EmergencyState {
  final String mess;

  SendLocationError(this.mess);
}
