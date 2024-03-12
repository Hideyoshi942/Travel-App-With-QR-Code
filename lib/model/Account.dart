class Account{
  late String _id;
  late String _user_name;
  late String _password;

  Account({required String id, required String userName, required String password}) {
    _id = id;
    _user_name = userName;
    _password = password;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get user_name => _user_name;

  set user_name(String value) {
    _user_name = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}