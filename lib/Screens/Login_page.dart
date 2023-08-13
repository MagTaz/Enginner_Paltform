// ignore_for_file: dead_code

import 'package:engineers_app/Screens/HomePage.dart';
import 'package:engineers_app/Screens/SignUpPage.dart';
import 'package:engineers_app/Services/UserServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'EngineerHomePage.dart';
// import 'package:test1_app/NavBar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

bool _isVisable = true;

class _LoginPageState extends State<LoginPage> {
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.all(5),
          height: height,
          width: width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 23, 153, 110),
            Color.fromARGB(255, 15, 93, 119)
          ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Container(
                    // المستطيل الابيض اللي يحتوي على جميع العناصر
                    height: height - 100,
                    width: width,
                    margin: const EdgeInsets.symmetric(
                        vertical: 50, horizontal: 30),
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black45,
                              spreadRadius: 5,
                              blurRadius: 30)
                        ]),
                    child: Column(
                      //العناصر على شكل عامودي
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 30),
                        // العنوان

                        const Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 40,
                              color: Color.fromARGB(255, 23, 153, 110)),
                        ),
                        const SizedBox(
                          height: 90,
                        ),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(15),
                              hintText: ("Enter your Email"),
                              prefixIcon: Icon(Icons.email),
                              prefixIconColor: Color.fromARGB(255, 15, 93, 119),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 15, 93, 119),
                                      width: 2.5),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 15, 93, 119)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          obscureText: _isVisable,
                          controller: _passwordController,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(15),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              hintText: ("Enter your password:"),
                              prefixIcon: const Icon(Icons.lock),
                              prefixIconColor:
                                  const Color.fromARGB(255, 15, 93, 119),
                              suffixIconColor:
                                  const Color.fromARGB(255, 15, 93, 119),
                              suffixIcon: IconButton(
                                icon: _isVisable
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _isVisable = !_isVisable;
                                  });
                                },
                              ),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 15, 93, 119),
                                      width: 2.5),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 15, 93, 119)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                        ),
                        const SizedBox(
                          height: 90,
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                                enableFeedback: true,
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 15, 93, 119))),
                            onPressed: () async {
                              try {
                                await UserServices().Login(
                                    _emailController.text.trim(),
                                    _passwordController.text.trim());
                                
                                  // ignore: use_build_context_synchronously
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EngineerHomePage()),
                                      ((route) => false));
                                       ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Color.fromARGB(255, 23, 153, 110),
                            content: Text("You are logged in",style: TextStyle(fontSize: 15),))
                        );
                                
                              } catch (e) {}
                            },
                            child: Container(
                                width: width,
                                child: const Text(
                                  "Login",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ))),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("I don't have an Acount"),
                            InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return SignupPage();
                                  }));
                                },
                                child: Text(
                                  " Create an Acount",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 23, 153, 110),
                                  ),
                                )),
                            const SizedBox(
                              height: 80,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
