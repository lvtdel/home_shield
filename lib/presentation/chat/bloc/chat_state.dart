part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatLoading extends ChatState {}

final class ChatSuccess extends ChatState {
  final Stream<List<Message>> streamMessList;

  ChatSuccess(this.streamMessList);
}

final class ChatError extends ChatState {
  final String mess;

  ChatError(this.mess);
}

final class ChatSendError extends ChatState {
  final String mess;

  ChatSendError(this.mess);
}