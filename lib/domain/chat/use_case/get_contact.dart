import 'package:dartz/dartz.dart';
import 'package:home_shield/domain/chat/entities/group.dart';
import 'package:home_shield/domain/chat/repository/chat_repository.dart';
import 'package:home_shield/domain/usecase.dart';
import 'package:home_shield/service_locator.dart';

class GetContactUseCase extends UseCase<Either<String, List<Group>>, void> {
  @override
  Future<Either<String, List<Group>>> call({void params}) {
    return sl<ChatRepository>().getContacts();
  }
}
