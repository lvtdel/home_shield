part of 'group_cubit.dart';

@immutable
sealed class GroupState {}

final class GroupInitial extends GroupState {}

final class LoadingGroup extends GroupState {}

final class GroupSuccess extends GroupState {
  final String groupName;

  GroupSuccess(this.groupName);
}

final class GroupError extends GroupState {
  final String mess;

  GroupError(this.mess);
}
