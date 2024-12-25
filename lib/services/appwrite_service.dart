import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:it/Models/lecture.dart';
import 'package:it/Models/subject.dart';
import 'package:uuid/uuid.dart';
import '../Models/Master.dart';
import '../Models/student.dart';

class AppwriteService {
  static final AppwriteService _singleton = AppwriteService._internal();
  static const dbId = "676317fb003556cd730a";
  static const masterCollectionId = "67632a270029ffbe3e73";
  static const studentCollectionId = "67631c2400321d8702d1";
  static const lectureCollectionId = '676706130032336e26f7';
  static const subjectCollectionId = '676706c9000c2d17447b';
  var uuid = Uuid();

  factory AppwriteService() {
    return _singleton;
  }

  AppwriteService._internal();

  Client client = Client()
      .setEndpoint('https://cloud.appwrite.io/v1') // Your API Endpoint
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
    final subject = (result.documents.first.data["subject"] as List<dynamic>)
        .map((e) => Subject.fromMap(e as Map<String, dynamic>))
        .toList();
    final s = Student(result.documents.first.$id, map["univNum"], map["name"],
        map["password"]);
    s.add_subject(subject);
    return s;
  }

  Future<void> updateStudent(Student s) async {
    Databases databases = Databases(client);
    final subjects = s.get_subject().map((e) {
      return "${e.id}";
    }).toList();
    Document result = await databases.updateDocument(
        databaseId: dbId,
        collectionId: studentCollectionId,
        documentId: s.id,
        data: {'subject': subjects});
  }

  Future<Student> postStudent(Student s) async {
    print(s.toMap());
    Databases databases = Databases(client);
    Document result = await databases.createDocument(
        databaseId: dbId,
        collectionId: studentCollectionId,
        documentId: uuid.v4(),
        data: {
          "name": s.get_name(),
          "password": s.get_pass(),
          "univNum": s.get_unvNum()
        });
    return Student(result.$id,result.data["univNum"],result.data["name"],result.data["password"]);
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
    return Master(map["phoneNumber"], map["name"], map["password"],
        result.documents.first.$id);
  }

  Future<void> updateMaster(Master s) async {
    Databases databases = Databases(client);
    final subjects = s.get_subject().map((e) {
      return "${e.id}";
    }).toList();
    Document result = await databases.createDocument(
        databaseId: dbId,
        collectionId: studentCollectionId,
        documentId: s.id,
        data: {'subject': subjects});
  }

  Future<Master> postMaster(Master s) async {
    Databases databases = Databases(client);
    Document result = await databases.createDocument(
        databaseId: dbId,
        collectionId: masterCollectionId,
        documentId: uuid.v4(),
        data: s.toMap());
    return Master(result.data["phoneNumber"],result.data["name"],result.data["password"],result.$id);
  }

////
  Future<Lecture> postLecture(Lecture lec) async {
    Databases databases = Databases(client);
    Document result = await databases.createDocument(
        databaseId: dbId,
        collectionId: lectureCollectionId,
        documentId: uuid.v4(),
        data: {
          'hallNumber': lec.hallNumber,
          'code_lectuer': lec.code,
          'name_master': lec.masterName,
          'subject': lec.subjectName,
          'titel': lec.title,
          'lecture_date': DateTime.now().toString(),
        });
    return Lecture.fromMap(result.toMap());
  }

  Future<List<Lecture>> getLectures(List<Subject> s) async {
    Databases databases = Databases(client);
    final subjects = s.map((e) {
      return "${e.id}";
    }).toList();
    DocumentList result = await databases.listDocuments(
        databaseId: dbId,
        collectionId: lectureCollectionId,
        queries: [
          Query.equal("subject", subjects),
          Query.equal("lecture_date", DateTime.now().day)
        ]);
    return result.documents.map((e) => Lecture.fromMap(e.toMap())).toList();
  }

  Future<void> updateLecture(Lecture lec) async {
    Databases databases = Databases(client);
    final students = lec.student.map((e) {
      return "${e.id}";
    }).toList();
    Document result = await databases.updateDocument(
        databaseId: dbId,
        collectionId: lectureCollectionId,
        documentId: lec.id,
        data: {'students': students});
  }

  Future<void> deleteLecture(Lecture lec) async {
    Databases databases = Databases(client);
    Document result = await databases.deleteDocument(
        databaseId: dbId,
        collectionId: lectureCollectionId,
        documentId: lec.id);
  }

  Future<Lecture> getLecture(String id) async {
    Databases databases = Databases(client);
    Document result = await databases.getDocument(
        databaseId: dbId, collectionId: lectureCollectionId, documentId: id);
    return Lecture.fromMap(result.toMap());
  }

  Future<List<Document>> getLectureDocs(List<Subject> s) async {
    Databases databases = Databases(client);
    final subjects = s.map((e) {
      return "${e.id}";
    }).toList();
    DocumentList result = await databases.listDocuments(
        databaseId: dbId,
        collectionId: lectureCollectionId,
        queries: [
          Query.equal("subject", subjects),
          // Query.equal("lecture_date", DateTime.now().day)
        ]);
    return result.documents;
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
      temp_map = result.documents[i].data;
      temp = Subject(temp_map["\$id"], temp_map['code'], temp_map['name'],
          temp_map['numUnites'], Master(00, temp_map['nameMaster'], "00", ""));
      res.add(temp);
    }
    return res;
  }
}
