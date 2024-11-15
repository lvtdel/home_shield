import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_shield/data/chat/source/chat_firebase_service.dart';
import 'package:home_shield/data/map/repositories/map_repository.dart';
import 'package:home_shield/domain/chat/entities/message.dart';
import 'package:home_shield/domain/chat/repository/chat_repository.dart';
import 'package:home_shield/firebase_options.dart';
import 'package:home_shield/service_locator.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  // Thiết lập môi trường kiểm thử
  setUpAll(() async {
    // TestWidgetsFlutterBinding.ensureInitialized();
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await initializeDependencies();
  });

  // test
  test("get friend location info should return list location info model ", () async {
    var locationInfos = await sl<MapRepository>().getFriendLocations();

    expect(locationInfos.isRight(), true);
    locationInfos.fold((_) {}, (locationInfos) {
      locationInfos.forEach((e)=>print(e.userName));
      expect(locationInfos.length, greaterThan(0));
    });
  });

}
