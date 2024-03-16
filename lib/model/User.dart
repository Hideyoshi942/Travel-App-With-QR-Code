class Usser{
  late int _id;
  late String _name;
  late DateTime _date;
  late int _phone_number;
  late String _id_account;
  late int _id_News_feed;
  User({required int id,
    required String name,
    required DateTime date,
    required int phone_number,
    required String id_account,
    required int id_news_feed
  }){
    _id = id;
    _name = name;
    _date = date;
    _phone_number = phone_number;
    _id_account = id_account;
    _id_News_feed = id_news_feed;
  }

  int get id_News_feed => _id_News_feed;

  set id_News_feed(int value) {
    _id_News_feed = value;
  }

  String get id_account => _id_account;

  set id_account(String value) {
    _id_account = value;
  }

  int get phone_number => _phone_number;

  set phone_number(int value) {
    _phone_number = value;
  }

  DateTime get date => _date;

  set date(DateTime value) {
    _date = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }
}