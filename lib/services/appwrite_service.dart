import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:it/Models/lecture.dart';
import 'package:it/Models/subject.dart';

import '../Models/Master.dart';
import '../Models/student.dart';

class AppwriteService {
  static final AppwriteService _singleton = AppwriteService._internal();
  static const dbId = "676317fb003556cd730a";
  static const masterCollectionId = "67632a270029ffbe3e73";
  static const studentCollectionId = "67631c2400321d8702d1";
  static const lectureCollectionId = '676706130032336e26f7';
  static const subjectCollectionId = '676706c9000c2d17447b';

  factory AppwriteService() {
    return _singleton;
  }

  AppwriteService._internal();

  Client client = Client()
      .setEndpoint('http://cloud.appwrite.io/v1') // Your API Endpoint
      .setProject('67631599002693c1b375');

  Future<void> Login() async {
    Account account = Account(client);
    await account.createAnonymousSession();
  }

  Future<void> LoginwithEmail() async {
    Account account = Account(client);

     await account.createEmailPasswordSession(
      email: 'useremail@email.com',
      password: '123456789faster',
    );
  }

  Future<Student> getStudent(int univNum) async {
    Databases databases = Databases(client);
    final result = await databases.listDocuments(
      databaseId: dbId,
      collectionId: studentCollectionId,
      queries: [
        //this is filter
        Query.equal("univNum", [univNum])
      ],
    );
    final map = result.documents.first.toMap()["data"];
    return Student(map["univNum"], map["name"], map["password"]);
  }

  Future<Master> getMaster(int phoneNumber) async {
    Databases databases = Databases(client);
    DocumentList result = await databases.listDocuments(
      databaseId: dbId,
      collectionId: masterCollectionId,
      queries: [
        //this is filter
        Query.equal("phoneNumber", [phoneNumber])
      ],
    );
    final map = result.documents.first.toMap()["data"];
    return Master(map["phoneNumber"], map["name"], map["password"]);
  }

////
  Future<void> postLecture(Lecture lec) async {
    Databases databases = Databases(client);
    Document result = await databases.createDocument(
        databaseId: dbId,
        collectionId: lectureCollectionId,
        documentId: '',
        data: {
          'ID': lec.id,
          'hallNumber': lec.hallNumber,
          'code_lectuer': lec.code,
          'name_master': lec.masterName,
          'name_subject': lec.subjectName,
          'titel': lec.title,
          'students': []
        });
  }

  Future<List<Subject>> getSubject() async {
    Databases databases = Databases(client);
    DocumentList result = await databases.listDocuments(
      databaseId: dbId,
      collectionId: subjectCollectionId,
    );
    List<Subject> res = [];
    var temp, temp_map;
    for (var i = 0; i < result.documents.length; i++) {
      temp_map = result.documents[i].toMap();
      temp = Subject(temp_map['code'], temp_map['name'], temp_map['numUnites'],
          temp_map['nameMaster']);
      res.add(temp);
    }
    return res;
  }
}
