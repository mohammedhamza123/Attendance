// كلاس المحاضرة
import 'package:it/Models/Master.dart';
import 'package:it/Models/student.dart';
import 'package:it/Models/subject.dart';

class Lecture {
  int id;
  int code;
  String hallNumber;
  String name_subject;
  String titel;
  String name_master;
  List<Student> student = [];
  Lecture(this.id, this.code, this.hallNumber, this.name_subject,
      this.name_master, this.titel);
}

List<Student> studentList = [
  Student(0, 17, 'محمد شنب', '123'),
];
List<Master> mastresList = [
  Master(0, 10, 'فاطمة الطاهر', '123'),
  Master(0, 11, 'فاطمة الطاهر', '123'),
];
// List<Subject> selectedSubjects = [];

List<Subject> Subjects = [
  Subject('mo101', "تطبيقات الهاتف", 3, mastresList[0]),
  Subject('mo101', "تطبيقات الهاتف", 3, mastresList[0]),
  Subject('mo101', "تطبيقات الهاتف", 3, mastresList[0]),
  Subject('mo101', "تطبيقات الهاتف", 3, mastresList[0]),
  Subject('mo101', "تطبيقات الهاتف", 3, mastresList[0]),
];
