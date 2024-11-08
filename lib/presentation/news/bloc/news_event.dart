part of 'news_bloc.dart';

@immutable
sealed class NewsEvent {}

class LoadData extends NewsEvent {}

class LikePost extends NewsEvent {
  final String postId;

  LikePost(this.postId);
}

class CommentPost extends NewsEvent {
  final Comment comment;

  CommentPost(this.comment);
}