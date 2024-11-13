import 'package:dartz/dartz.dart';
import 'package:home_shield/domain/emergency/use_case_params/send_loaction_params.dart';

abstract class EmergencyRepository {
  Future<Either<String, bool>> sendLocation(SendLocationParams location);
}
