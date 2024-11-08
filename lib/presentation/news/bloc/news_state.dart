part of 'news_bloc.dart';

@immutable
sealed class NewsState {}

final class NewsInitial extends NewsState {}

final class NewsLoading extends NewsState {}

final class NewsShowData extends NewsState {
  final List<Post> posts;

  NewsShowData(this.posts);
}

final class NewsError extends NewsState {
  final String mess;

  NewsError(this.mess);
}
