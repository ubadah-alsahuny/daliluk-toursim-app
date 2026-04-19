import 'package:dio/dio.dart';

Dio dio() {
  var dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.254.28.189:8000/api/',
      responseType: ResponseType.json,
      headers: {
        'accept': 'application/json',
        'content-type': 'application/json',
      },
    ),
  );

  return dio;
}
