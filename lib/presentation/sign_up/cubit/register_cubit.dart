import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:home_shield/domain/auth/use_cases/sign_up.dart';
import 'package:home_shield/domain/auth/entites/user.dart';
import 'package:home_shield/service_locator.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  register(UserApp user) async {
    var useCase = sl<SignupUseCase>();
    var param = user;

    emit(RegisterLoading());

    try {
      Either returnedData = await useCase.call(params: param);

      returnedData.fold((error) {
        emit(RegisterError(error));
      }, (data) {
        emit(RegisterSuccess());
      });
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}
