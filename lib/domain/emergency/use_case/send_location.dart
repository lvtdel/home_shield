import 'package:dartz/dartz.dart';
import 'package:home_shield/domain/emergency/repository/emergency_repository.dart';
import 'package:home_shield/domain/emergency/use_case_params/send_loaction_params.dart';
import 'package:home_shield/domain/usecase.dart';
import 'package:home_shield/service_locator.dart';

class SendLocationUseCase
    extends UseCase<Either<String, bool>, SendLocationParams> {
  @override
  Future<Either<String, bool>> call({SendLocationParams? params}) {
    return sl<EmergencyRepository>().sendLocation(params!);
  }
}
