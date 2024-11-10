import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_shield/data/chat/source/chat_firebase_service.dart';
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
  test("get contact should return list group", () async {
    var groups = await sl<ChatRepository>().getContacts();

    expect(groups.isRight(), true);
    groups.fold((_) {}, (groups) {
      expect(groups.length, greaterThan(0));
    });
  });

  test("service get messages, should return list MessageModel", () async {
    var groupId = "iors7V6WETQ5zm0RTBMb";
    var messages = await sl<ChatFirebaseService>().getMessages(groupId);

    expect(messages.isRight(), true);
    messages.fold((e) {}, (messagesStream) {
      messagesStream.listen((messages) {
        expect(messages.length, greaterThan(0));
        expect(messages.first.content, isNotNull);
      });
    });
  });

  test("repository get messages, should return list message", () async {
    var groupId = "iors7V6WETQ5zm0RTBMb";
    var messages = await sl<ChatRepository>().getMessages(groupId);

    expect(messages.isRight(), true);
    messages.fold((e) {}, (messagesStream) {
      messagesStream.listen((messages) {
        expect(messages.length, greaterThan(0));
        expect(messages.first.content, isNotNull);
      });
    });
  });

  test("send message", () async {
    var groupId = "iors7V6WETQ5zm0RTBMb";
    var mess = Message(content: "Hello 1234", createdAt: Timestamp.now());

    var data = await sl<ChatRepository>().sendMessage(mess, groupId);

    expect(data.isRight(), true);
    data.fold((e) {
      print(e);
    }, (data) {
print(data);
    });
  });
}
