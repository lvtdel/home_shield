import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_shield/domain/auth/use_cases/get_user.dart';
import 'package:home_shield/domain/auth/use_cases/sign_in.dart';
import 'package:home_shield/domain/entities/user.dart';
import 'package:home_shield/service_locator.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  login(String email, String password) async {
    UserApp user = UserApp(email: email, password: password);

    try {
      var useCase = sl<SignInUseCase>();
      var param = user;

      Either returnedData = await useCase.call(params: param);
      returnedData.fold((error) {
        emit(LoginError(error));
      }, (_) async {
        var getUserUseCase = sl<GetUserUseCase>();
        Either userResult = await getUserUseCase.call();

        userResult.fold(
          (error) {
            emit(LoginError(error));
            // Xử lý lỗi nếu không lấy được thông tin người dùng
          },
          (user) {
            emit(LoginSuccess(user.name));
            // Emit trạng thái thành công với người dùng hiện tại
          },
        );
      });
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
