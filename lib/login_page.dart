import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> fKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    SharedPreferences.getInstance().then((pref) {
      var isLogin = pref.getBool("isLogin");
      if (isLogin ?? false) {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return ContactPage();
          },
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.book_outlined, size: 30),
          )
        ],
        title: Text(
          "Contact Diary",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.white],
              ),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Form(
                key: fKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: email,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Email Address";
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: pass,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter password";
                        }
                      },
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () async {
                        var isVal = fKey.currentState?.validate() ?? false;
                        if (isVal) {
                          if (email.text == "harshvasoya@gmail.com" &&
                              pass.text == "hd@123") {
                            var sp = await SharedPreferences.getInstance();
                            await sp.setBool("isLogin", true);

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ContactPage(),
                                ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.blue,
                                content: Center(
                                    child: Text(
                                  "Invalid",
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                )),
                              ),
                            );
                          }
                        }
                      },
                      child: Text("Login"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
