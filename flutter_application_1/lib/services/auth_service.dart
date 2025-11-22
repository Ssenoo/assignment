class AuthService {

  AuthService._internal();


  static final AuthService _instance = AuthService._internal();


  factory AuthService() {
    return _instance;
  }


  final Map<String, String> _users = {};


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

    if (_users.containsKey(username) && _users[username] == password) {
      return true;
    }
    return false;
  }
}
