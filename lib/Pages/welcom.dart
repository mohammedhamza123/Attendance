import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String? typ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,

          //     gradient: LinearGradient(colors: [
          //   Color.fromARGB(255, 18, 153, 29),
          //   Color.fromARGB(255, 40, 88, 54),
          // ])
        ),
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.only(top: 100),
            child: SizedBox(
                width: 250,
                height: 190,
                child: Image(image: AssetImage('images/Picture1.png'))),
          ),
          const SizedBox(
            height: 70,
          ),
          const Text(
            'مرحبا بك ',
            style: TextStyle(
                fontSize: 30, color: Color.fromARGB(255, 36, 132, 83)),
          ),
          RadioListTile<String>(
            secondary: Icon(Icons.school_sharp),
            activeColor: Color.fromARGB(255, 36, 132, 83),
            title: const Text('طالب'),
            value: 'طالب',
            groupValue: typ,
            onChanged: (String? value) {
              setState(() {
                typ = value;
              });
            },
          ),
          RadioListTile<String>(
            secondary: Icon(Icons.person),
            activeColor: Color.fromARGB(255, 36, 132, 83),
            title: const Text('عضو هيئة تدريس'),
            value: 'عضو هيئة تدريس',
            groupValue: typ,
            onChanged: (String? value) {
              setState(() {
                typ = value;
              });
            },
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            height: 53,
            width: 320,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.black),
            ),
            child: Center(
              child: TextButton(
                onPressed: () {
                  if (typ == 'طالب') {
                    Navigator.pushNamed(context, '/Login',
                        arguments: {"acc": "student"});
                  } else if (typ == 'عضو هيئة تدريس') {
                    Navigator.pushNamed(context, '/Login',
                        arguments: {"acc": "master"});
                  }
                },
                child: Text(
                  'تسجيل الدخول',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            height: 53,
            width: 320,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 9, 82, 32),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white),
            ),
            child: Center(
                child: TextButton(
              onPressed: () {
                if (typ == 'طالب') {
                  Navigator.pushNamed(context, '/Register',
                      arguments: {"acc": "student"});
                } else if (typ == 'عضو هيئة تدريس') {
                  Navigator.pushNamed(context, '/Register',
                      arguments: {"acc": "master"});
                }
              },
              child: Text(
                'انشاء حساب',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            )),
          ),
          const Spacer(),
          const SizedBox(
            height: 12,
          ),
        ]),
      ),
    );
  }
}
