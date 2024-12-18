//كلاس المواد
import 'package:it/Models/Master.dart';

class Subject {
  String _code;
  String _name;
  Master _nameMaster;
  int _numUnites = 0;
  Subject(this._code, this._name, this._numUnites, this._nameMaster);
  int get_numUnites() {
    return _numUnites;
  }

  String get_code() {
    return _code;
  }

  String get_name() {
    return _name;
  }

  Master get_name_master() {
    return _nameMaster;
  }
}
