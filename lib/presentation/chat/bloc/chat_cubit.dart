import 'package:bloc/bloc.dart';
import 'package:home_shield/domain/chat/entities/message.dart';
import 'package:home_shield/domain/chat/use_case/get_message.dart';
import 'package:home_shield/domain/chat/use_case/send_message.dart';
import 'package:home_shield/domain/chat/use_case_params/send_message_params.dart';
import 'package:home_shield/service_locator.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  loadStreamMess(String groupId) async {
    emit(ChatLoading());

    var useCase = sl<GetMessageUseCase>();
    var data = await useCase.call(params: groupId);

    data.fold((e) {
      emit(ChatError(e));
    }, (streamMess) {
      emit(ChatSuccess(streamMess));
    });
  }

  Future<bool> sendMess(Message mess, String groupId) async {
    var useCase = sl<SendMessageUseCase>();
    var params = SendMessageParams(message: mess, groupId: groupId);

    var data = await useCase.call(params: params);

    bool result = false;

    data.fold((e) {
      emit(ChatSendError(e));
      result = false;
    }, (isSuccess) {
      result = true;
    });

    return result;
  }
}
