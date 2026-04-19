import 'dart:convert';

import 'package:dio/dio.dart' as dio_variable;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tourism_app/dio.dart';
import 'package:tourism_app/models/user.dart';

class Auth extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();

  bool _authenticated = false;
  bool _initialized = false;

  User? _user;
  String? _token;

  bool get authenticated => _authenticated;
  User? get user => _user;
  bool get initialized => _initialized;
  String? get token => _token;

  Future signUp({Map? credentials}) async {
    try {
      var response = await dio().post(
        'register',
        data: json.encode(credentials),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("SERVER DATA: ${response.data}");

        final responseData = response.data['data'];

        String token = responseData['token'].toString();
        await _storage.write(key: "auth_token", value: token);

        _user = User.fromJson(responseData['user']);

        _authenticated = true;
        notifyListeners();
      }
    } on dio_variable.DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future login({Map? credentials}) async {
    try {
      var response = await dio().post('login', data: json.encode(credentials));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data['data'];

        String token = responseData['token'].toString();

        await _storage.write(key: "auth_token", value: token);

        _user = User.fromJson(responseData['user']);

        _authenticated = true;
        notifyListeners();
      }
    } on dio_variable.DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<void> attempt() async {
    try {
      String? token = await _storage.read(key: 'auth_token');

      if (token != null) {
        var response = await dio().get(
          'user',
          options: dio_variable.Options(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );

        print("ATTEMPT USER DATA: ${response.data} ${token}");

        _user = User.fromJson(response.data);
        _authenticated = true;
        _token = token;
        notifyListeners();
      }
    } catch (e) {
      print("Attempt Error: $e");
      await _storage.delete(key: 'auth_token');
    } finally {
      _initialized = true;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      await dio().post(
        'logout',
        options: dio_variable.Options(
          headers: {'Authorization': 'Bearer $_token'},
        ),
      );
    } catch (e) {
      print('Logout error on server: $e');
    } finally {
      await _storage.delete(key: 'auth_token');

      _authenticated = false;
      _user = null;
      _token = null;

      notifyListeners();
    }
  }

  String _handleDioError(dio_variable.DioException e) {
    if (e.response?.statusCode == 422) {
      final Map<String, dynamic> errors = e.response?.data['errors'];
      return errors.values.first[0];
    }
    return "معلومات الإدخال خاطئة";
  }
}
