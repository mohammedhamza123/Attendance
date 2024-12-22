// كلاس المحاضرة
import 'package:it/Models/Master.dart';
import 'package:it/Models/student.dart';
import 'package:it/Models/subject.dart';

class Lecture {
  int code;
  String hallNumber;
  String subjectName;
  String title;
  String masterName;
  List<Student> student = [];

  Lecture(this.code, this.hallNumber, this.subjectName, this.masterName,
      this.title);
}

List<Student> studentList = [];
// List<Student> studentList = [
//   Student(0, 17, 'محمد شنب', '123'),
// ];
List<Master> masterList = [];
// List<Master> masterList = [
//   Master(0, 10, 'فاطمة الطاهر', '123'),
//   Master(0, 11, 'فاطمة الطاهر', '123'),
// ];
List<Subject> selectedSubjects = [];
List<Subject> subjects = [];
// List<Subject> Subjects = [
//   Subject('mo101', "تطبيقات الهاتف", 3, mastresList[0]),
//   Subject('mo101', "تطبيقات الهاتف", 3, mastresList[0]),
//   Subject('mo101', "تطبيقات الهاتف", 3, mastresList[0]),
//   Subject('mo101', "تطبيقات الهاتف", 3, mastresList[0]),
//   Subject('mo101', "تطبيقات الهاتف", 3, mastresList[0]),
// ];
