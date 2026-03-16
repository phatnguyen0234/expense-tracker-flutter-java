import 'package:dio/dio.dart';
import '../storage/secure_storage.dart';

class DioClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: "http://localhost:8080/api/v1",
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  )..interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await SecureStorage.getToken();

        if (token != null) {
          options.headers["Authorization"] = "Bearer $token";
        }

        print("REQUEST: ${options.method} ${options.path}");
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print("RESPONSE: ${response.statusCode}");
        return handler.next(response);
      },
      onError: (error, handler) {
        print("ERROR: ${error.response?.statusCode}");
        return handler.next(error);
      },
    ),
  );
}