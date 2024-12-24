part of 'emer_global_bloc.dart';

@immutable
sealed class EmerGlobalEvent {}

final class ShakeDetected extends EmerGlobalEvent {}