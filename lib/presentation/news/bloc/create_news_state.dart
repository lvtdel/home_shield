part of 'create_news_cubit.dart';

@immutable
sealed class CreateNewsState {}

final class CreateNewsInitial extends CreateNewsState {}
final class CreateNewsLoading extends CreateNewsState {}

final class CreateNewsShowData extends CreateNewsState {
  final UserApp userApp;
   String? image;

  CreateNewsShowData(this.userApp, [this.image]);
}

final class CreateNewsSuccess extends CreateNewsState
{

}
final class CreateNewsError extends CreateNewsState {
  final String mess;

  CreateNewsError(this.mess);
}
