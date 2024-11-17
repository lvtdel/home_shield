import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_shield/data/notification/models/notification_model.dart';
import 'package:home_shield/data/notification/repositories/notification_repostitory.dart';
import 'package:home_shield/domain/chat/entities/message.dart';
import 'package:home_shield/domain/chat/repository/chat_repository.dart';
import 'package:home_shield/firebase_options.dart';
import 'package:home_shield/service_locator.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  setUpAll(() async {
    // TestWidgetsFlutterBinding.ensureInitialized();
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await initializeDependencies();
  });

  test("send notification", () async {
    var receiverId = "TcZ8knsLiAXiE686zuZ1mIJSnwq2";

    NotificationModel? notificationModel = NotificationModel(
        content: "Hãy tham gia vào nhóm Giải đề thi thử 2021",
        params: "iors7V6WETQ5zm0RTBMb",
        type: "GROUP_INVITE",
        createdAt: Timestamp.now(),
        image:
            "https://firebasestorage.googleapis.com/v0/b/home-shield-ce8cb.firebasestorage.app/o/images%2Fgroup%2Fnotification_1540708456-900x900.png?alt=media&token=7c7caf50-a46f-4e46-9ca5-c1b6ed9d08d8");

    var data = await sl<NotificationRepository>()
        .pushNotif(notificationModel, receiverId);

    expect(data.isRight(), true);
    data.fold((e) {
      print(e);
    }, (data) {
      print(data);
    });
  });
}
