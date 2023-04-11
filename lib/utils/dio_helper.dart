import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;
  static String baseUrl = "https://parseapi.back4app.com/";
  static void initialize({String token = ""}) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          "accept": "application/json",
          "X-Parse-Application-Id": "wGFb41nwhf2aNh4W9UxRHueQ3J0h7QZ7kSGTSTa2",
          "X-Parse-REST-API-Key": "NvEyBcWJxNzeEQkNqGEjyKG1p6QCYOitNg6wz6ew",
          "X-Parse-Session-Token": token,
        },
        receiveDataWhenStatusError: true,
        validateStatus: (status) => (status ?? 0) <= 500,
      ),
    );
  }
}
