import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_shield/data/chat/models/group_model.dart';
import 'package:home_shield/data/group/repositories/group_repository.dart';
import 'package:home_shield/service_locator.dart';
import 'package:meta/meta.dart';

part 'group_state.dart';

class GroupCubit extends Cubit<GroupState> {
  GroupCubit() : super(GroupInitial());

  Future<void> createGroup(String name, File file, List<String> otherMemberEmails) async {
    emit(LoadingGroup());

    GroupModel groupModel = GroupModel(image: "", name: name, userIds: otherMemberEmails);

    var result = await sl<GroupRepository>().createGroup(file, groupModel);
    result.fold((e) {
      emit(GroupError(e.replaceFirst("Exception: ", "")));
    }, (data) {
      emit(GroupSuccess(data));
    });
  }
}
