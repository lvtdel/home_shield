part of 'contact_cubit.dart';

@immutable
sealed class ContactState {}

final class ContactInitial extends ContactState {}

final class ContactLoading extends ContactState {}

final class ContactSuccess extends ContactState {
  final List<Group> groups;

  ContactSuccess(this.groups);
}

final class ContactError extends ContactState {
  final String mess;

  ContactError(this.mess);
}
