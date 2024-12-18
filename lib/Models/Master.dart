//كلاس الااستاذ
import 'package:it/Models/subject.dart';

class Master {
  int _phone;
  String _name;
  String _password;
  List<Subject> _subjectes = [];

  Master( this._phone, this._name, this._password);
  int get_phone() {
    return _phone;
  }

  String get_pass() {
    return _password;
  }

  String get_name() {
    return _name;
  }

  int get_count_sub() {
    return _subjectes.length;
  }

  void add_subject(List<Subject> sub) {
    _subjectes = sub;
  }

  List get_subject() {
    return _subjectes;
  }
}
