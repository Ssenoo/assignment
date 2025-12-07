import 'package:dio/dio.dart';

class AuthService {
  AuthService._internal();

  static final AuthService _instance = AuthService._internal();

  factory AuthService() {
    return _instance;
  }

  final Map<String, String> _users = {};
  final Dio _dio = Dio();

  Future<bool> signUp(String username, String password) async {
    if (username.isEmpty || password.length < 6) {
      return false;
    }

    if (_users.containsKey(username)) {
      return false;
    }

    _users[username] = password;
    return true;
  }

  Future<bool> login(String username, String password) async {
    try {
      final response = await _dio.post(
        'https://dummyjson.com/auth/login',
        data: {
          'username': username,
          'password': password,
          'expiresInMins': 30,
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );


      if (response.statusCode == 200) {
        print('=== ✅ LOGIN SUCCESS ===');
        print('Status Code: ${response.statusCode}');
        print('User ID: ${response.data['id']}');
        print('Username: ${response.data['username']}');
        print('Email: ${response.data['email']}');
        print('Name: ${response.data['firstName']} ${response.data['lastName']}');
        print('Access Token: ${response.data['accessToken']}');
        print('Refresh Token: ${response.data['refreshToken']}');
        print('========================');
        return true;
      }

      return false;
    } on DioException catch (e) {

      print('=== ❌ LOGIN FAILED ===');
      
      if (e.response != null) {

        print('Status Code: ${e.response?.statusCode}');
        print('Error Message: ${e.response?.data}');
        
        if (e.response?.statusCode == 400) {
          print('Reason: Invalid credentials - Username or password is incorrect');
        } else if (e.response?.statusCode == 401) {
          print('Reason: Unauthorized - Authentication failed');
        } else {
          print('Reason: Server error');
        }
      } else {

        print('Error Type: ${e.type}');
        print('Error Message: ${e.message}');
        
        if (e.type == DioExceptionType.connectionTimeout) {
          print('Reason: Connection timeout - Server took too long to respond');
        } else if (e.type == DioExceptionType.receiveTimeout) {
          print('Reason: Receive timeout - Server response took too long');
        } else if (e.type == DioExceptionType.connectionError) {
          print('Reason: Connection error - Check your internet connection');
        } else {
          print('Reason: Network error');
        }
      }
      
      print('=======================');
      return false;
    } catch (e) {
      print('=== ❌ UNEXPECTED ERROR ===');
      print('Error: $e');
      print('===========================');
      return false;
    }
  }
}
