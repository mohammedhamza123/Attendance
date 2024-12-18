// كلاسس الطالب
import 'package:it/Models/subject.dart';

class Student {
  int _univNum;
  int maxUnite = 18;
  int minUnite = 14;
  String _name;
  String _password;
  List<Subject> _subjectes = [];
  Student(this._univNum, this._name, this._password);

  int get_unvNum() {
    return _univNum;
  }

  void set_unvNum(int n) {
    _univNum = n;
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

  void add_subject(List<Subject> s) {
    _subjectes = s;
  }

  List get_subject() {
    return _subjectes;
  }
}
