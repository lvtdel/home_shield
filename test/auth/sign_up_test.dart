import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_shield/domain/auth/use_cases/sign_up.dart';
import 'package:home_shield/domain/auth/entites/user.dart';
import 'package:home_shield/firebase_options.dart';
import 'package:home_shield/service_locator.dart';


void main() async {
  // Thiết lập môi trường kiểm thử
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.windows);
    await initializeDependencies();
  });

  test("Sign up", () async {
    // Lấy SignupUseCase từ DI
    var signupUseCase = sl<SignupUseCase>();

    // Tạo đối tượng UserApp với các tham số kiểm thử
    var userApp = UserApp(
      name: "Vo The Luc",
      email: "votheluc01@gmail.com",
      phoneNumber: "0915941874",
      password: "abba1221",
      bloodType: "B",
    );

    // Thực thi kiểm thử
    var result = await signupUseCase.call(params: userApp);

    // Kiểm tra kết quả để xem nó có như mong đợi không (tuỳ thuộc vào logic bạn đã viết)
    expect(result, isNotNull);
  });
}
