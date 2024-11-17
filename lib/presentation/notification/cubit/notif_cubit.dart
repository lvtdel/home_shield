import 'package:bloc/bloc.dart';
import 'package:home_shield/data/notification/models/notification_model.dart';
import 'package:home_shield/data/notification/repositories/notification_repostitory.dart';
import 'package:home_shield/service_locator.dart';
import 'package:meta/meta.dart';

part 'notif_state.dart';

class NotifCubit extends Cubit<NotifState> {
  NotifCubit() : super(NotifInitial());

  getNotif() async {
    emit(NotifLoad());

    var data = await sl<NotificationRepository>().getNotif();

    data.fold((e) {}, (data) {
      emit(ShowNotif(data));
    });
  }

  Future<bool> acceptNotif(NotificationModel notif) async {
    var data = await sl<NotificationRepository>().acceptNotif(notif);

    if (data.isRight()) return true;

    return false;
  }

  Future<bool> deleteNotif(String notifId) async {
    var data = await sl<NotificationRepository>().deleteNotif(notifId);

    if (data.isRight()) return true;

    return false;
  }
}
