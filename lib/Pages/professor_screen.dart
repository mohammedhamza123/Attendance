import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import '../Models/Master.dart';
import 'select_data_lect.dart';


class MasterScreen extends StatefulWidget {
  @override
  _MasterScreenState createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  int? lectureCode;
  List<String> studentAttendance = [];

  void generateLectureCode() {
    setState(() {});
  }

  Future<void> exportAttendanceToPDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("قائمة الحضور", style: pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 16),
              pw.Text("رقم المحاضرة: $lectureCode"),
              pw.SizedBox(height: 16),
              pw.Text("الأسماء:", style: pw.TextStyle(fontSize: 18)),
              ...studentAttendance.map((name) => pw.Text("- $name")),
            ],
          );
        },
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/attendance.pdf');
    await file.writeAsBytes(await pdf.save());
    print(directory.path);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("تم تصدير الحضور إلى ملف PDF: ${file.path}"),
      backgroundColor: Colors.green,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final master = ModalRoute.of(context)!.settings.arguments as Master;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 36, 132, 83),
        title: Text('مرحبا أ . ' + master.get_name()),
        centerTitle: true,
      ),
      body: Container(
        width: size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Text(
                textAlign: TextAlign.center,
                'حدد رقم المحاضرة و عنوانها و اختر القاعة و اضغط علي بدء لبدء المحاضرة',
                style: TextStyle(fontSize: 22),
              ),
            ),
            Divider(
              color: Color.fromARGB(255, 36, 132, 83),
              height: 3,
              endIndent: 10,
              indent: 10,
            ),

            Expanded(
              child: ListView.builder(
                itemCount: master.get_subject().length,
                itemBuilder: (context, index) {
                  return carts(sub: master.get_subject()[index]);
                },
              ),
            ),
            // ElevatedButton.icon(
            //   onPressed: generateLectureCode,
            //   icon: Icon(Icons.refresh),
            //   label: Text("إنشاء رقم المحاضرة"),
            //   style: ElevatedButton.styleFrom(
            //     padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            //   ),
            // ),
            // SizedBox(height: 20),
            // if (lectureCode != null)
            //   Column(
            //     children: [
            //       Text(
            //         "رقم المحاضرة: $lectureCode",
            //         style: TextStyle(
            //             fontSize: 28, color: Color.fromARGB(255, 13, 70, 34)),
            //         textAlign: TextAlign.center,
            //       ),
            // SizedBox(height: 20),
            // ElevatedButton.icon(
            //   onPressed: () {
            //     Navigator.pushNamed(
            //       context,
            //       '/student',
            //       arguments: {'code': lectureCode, 'list': studentAttendance},
            //     );
            //   },
            //   icon: Icon(Icons.send),
            //   label: Text("إرسال الرقم للطلاب"),
            //   style: ElevatedButton.styleFrom(
            //     padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            //   ),
            // ),
            //     SizedBox(height: 20),
            //     ElevatedButton.icon(
            //       onPressed: exportAttendanceToPDF,
            //       icon: Icon(Icons.picture_as_pdf),
            //       label: Text("تصدير قائمة الحضور إلى PDF"),
            //       style: ElevatedButton.styleFrom(
            //         padding:
            //             EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
