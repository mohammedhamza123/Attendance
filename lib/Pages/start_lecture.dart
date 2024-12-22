import 'package:flutter/material.dart';
import 'package:it/Models/lecture.dart';

class StartLecture extends StatefulWidget {
  const StartLecture({super.key});

  @override
  State<StartLecture> createState() => _StartLectureState();
}

class _StartLectureState extends State<StartLecture> {
  @override
  Widget build(BuildContext context) {
    final Lecture lec = ModalRoute.of(context)?.settings.arguments as Lecture;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 36, 132, 83),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.red,
            )),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            margin: EdgeInsets.fromLTRB(10, 30, 10, 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                    color: Color.fromARGB(255, 36, 132, 83), width: 2)),
            child: Column(
              children: [
                Text(
                  'اسم المادة : ' + lec.subjectName,
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'اسم المحاضر : ' + lec.masterName,
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Text(
                //   'رقم المحاضرة : ' + lec.id.toString(),
                //   style: TextStyle(fontSize: 18),
                // ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'عنوان المحاضرة : ' + lec.title,
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'رقم القاعة : ' + lec.hallNumber,
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'كود تسجيل الحضور : ' + lec.code.toString(),
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(top: 15, bottom: 15),
            decoration: BoxDecoration(color: Color.fromARGB(255, 36, 132, 83)),
            child: Text(
              textAlign: TextAlign.center,
              'اسماء الطلبة الحاضرون',
              style: TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: studentList.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(studentList[index].get_name()),
                subtitle: Text(DateTime.now().toString()),
                trailing: Text(studentList.length.toString()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
