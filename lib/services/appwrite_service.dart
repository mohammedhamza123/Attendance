import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:it/Models/lecture.dart';

import '../Models/Master.dart';
import '../Models/student.dart';

class AppwriteService {
  static final AppwriteService _singleton = AppwriteService._internal();

  factory AppwriteService() {
    return _singleton;
  }

  AppwriteService._internal();

  Client client = Client()
      .setEndpoint('https://cloud.appwrite.io/v1') // Your API Endpoint
      .setProject('67631599002693c1b375');
  Future<void> Login() async {
    Account account = Account(client);
    Session result = await account.createAnonymousSession();
  }

  Future<Student> getStudent(int univNum) async {
    Databases databases = Databases(client);
    DocumentList result = await databases.listDocuments(
      databaseId: '676317fb003556cd730a',
      collectionId: '67631c2400321d8702d1',
      queries: [
        //this is filter
        Query.equal("univNum", [univNum])
      ],
    );
    final map = result.documents.first.toMap();
    return Student(map["univNum"], map["name"], map["password"]);
  }

  Future<Master> getMaster(int phoneNumber) async {
    Databases databases = Databases(client);
    DocumentList result = await databases.listDocuments(
      databaseId: '676317fb003556cd730a',
      collectionId: '67632a270029ffbe3e73',
      queries: [
        //this is filter
        Query.equal("phoneNumber", [phoneNumber])
      ],
    );
    final map = result.documents.first.toMap();
    return Master(map["phoneNumber"], map["name"], map["password"]);
  }

////
Future<void> post_lectuer(Lecture lec) async {
    Databases databases = Databases(client);
    Document result = await databases.createDocument(
    databaseId: '676317fb003556cd730a',
    collectionId: '67632a270029ffbe3e73',
    documentId: '',
    data: {
      'ID':lec.id,
      'hallNumber':lec.hallNumber,
      'code':lec.code,
      'master_master':lec.name_master,
      'name_subject':lec.name_subject,
      'titel':lec.titel,

    }
    );
  }  
}
