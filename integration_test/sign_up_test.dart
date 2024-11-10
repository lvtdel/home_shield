import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_shield/domain/auth/use_cases/sign_in.dart';
import 'package:home_shield/domain/auth/use_cases/sign_up.dart';
import 'package:home_shield/domain/auth/entites/user.dart';
import 'package:home_shield/firebase_options.dart';
import 'package:home_shield/service_locator.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  // Thiết lập môi trường kiểm thử
  setUpAll(() async {
    // TestWidgetsFlutterBinding.ensureInitialized();
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await initializeDependencies();
  });

  test("Sign up", () async {
    // Lấy SignupUseCase từ DI
    var signupUseCase = sl<SignupUseCase>();
    var signInUseCase = sl<SignInUseCase>();

    // Tạo đối tượng UserApp với các tham số kiểm thử
    var userApp = UserApp(
      name: "Tran Minh Quang",
      email: "quangtm.21it@vku.udn.vn",
      phoneNumber: "0956941874",
      password: "abba1221",
      bloodType: "A",
    );

    // Thực thi kiểm thử
    var result = await signupUseCase.call(params: userApp);

    var signInResult = await signInUseCase.call(params: userApp);
    expect(signInResult.isRight(), true);
  });
}
