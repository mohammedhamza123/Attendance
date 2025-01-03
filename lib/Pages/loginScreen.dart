import 'package:flutter/material.dart';
import 'package:it/services/appwrite_service.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final services = AppwriteService();
  TextEditingController _numControllaer = TextEditingController();
  TextEditingController _passwordControllaer = TextEditingController();
  String acc = "master";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final Map<String, dynamic> args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      acc = args["acc"];
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    acc = args["acc"];
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 36, 132, 83),
          ),
          child: const Padding(
            padding: EdgeInsets.only(top: 60.0, left: 22),
            child: Text(
              textAlign: TextAlign.center,
              'مرحبا\nتسجيل الدخول ! ',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 200.0),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              color: Colors.white,
            ),
            height: double.infinity,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18),
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  TextField(
                    controller: _numControllaer,
                    decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.check,
                          color: Colors.grey,
                        ),
                        label: Text(
                          acc == "student" ? 'رقم القيد' : "رقم الهاتف",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 40, 88, 54),
                          ),
                        )),
                  ),
                  TextField(
                    controller: _passwordControllaer,
                    decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        label: Text(
                          'كلمة المرور',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 40, 88, 54),
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'هل نسيت كلمة المرور؟',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Color.fromARGB(255, 40, 88, 54),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Container(
                    height: 55,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color.fromARGB(255, 36, 132, 83),
                    ),
                    child: Center(
                      child: TextButton(
                          onPressed: () async {
                            try {
                              if (_numControllaer.text.isNotEmpty &&
                                  _passwordControllaer.text.isNotEmpty) {
                                final unvNum = int.parse(_numControllaer.text);
                                if (args["acc"] == "student") {
                                  final student =
                                      await services.getStudent(unvNum);
                                  if (int.parse(_numControllaer.text) ==
                                          student.get_unvNum() &&
                                      _passwordControllaer.text ==
                                          student.get_pass()) {
                                    if (student.get_subject().isEmpty) {
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          '/Select-Subjectes-Student',
                                          arguments: student,
                                          (Route<dynamic> route) => false);
                                    } else {
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          '/Student-Screen',
                                          arguments: student,
                                          (Route<dynamic> route) => false);
                                    }
                                  }
                                } else {
                                  final master =
                                      await services.getMaster(unvNum);
                                  if (int.parse(_numControllaer.text) ==
                                          master.get_phone() &&
                                      _passwordControllaer.text ==
                                          master.get_pass()) {
                                    if (master.get_subject().isEmpty) {
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          '/Select-Subjectes-Master',
                                          arguments: master,
                                          (Route<dynamic> route) => false);
                                    } else {
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          '/Master-Screen',
                                          arguments: master,
                                          (Route<dynamic> route) => false);
                                    }
                                  }
                                }
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'فشل في تسجيل الدخول. يرجى التحقق من الرقم السري أو الرقم الجامعي.',
                                    style: TextStyle(
                                        color: Colors
                                            .white), // White text on red background
                                  ),
                                  backgroundColor: Colors
                                      .red, // Red background for the error
                                ),
                              );
                            }
                          },
                          child: Text(
                            'تسجيل الدخول',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 150,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
