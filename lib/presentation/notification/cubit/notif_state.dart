part of 'notif_cubit.dart';

@immutable
sealed class NotifState {}

final class NotifInitial extends NotifState {}

final class NotifLoad extends NotifState {}

final class ShowNotif extends NotifState {
  final Stream<List<NotificationModel>> notifListStream;

  ShowNotif(this.notifListStream);
}

final class NotifError extends NotifState {
  final String mess;

  NotifError(this.mess);
}
