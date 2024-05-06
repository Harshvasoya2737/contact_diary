import 'dart:async';

import 'package:contact_diary/login_page.dart';
import 'package:flutter/material.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(seconds: 5),
      () {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return LoginPage();
          },
        ));
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 230,
                  ),
                  Image.asset(
                    'assets/images/contactlogo.png',
                    height: 200,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Contact Diary",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(150),
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
