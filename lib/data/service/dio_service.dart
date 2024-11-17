import 'package:dio/dio.dart';
import 'package:home_shield/core/constant/app_constant.dart';

class DioClient {
  final Dio dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
    headers: {'api-key': AppConstant.deepAiToken},
  ));
}
