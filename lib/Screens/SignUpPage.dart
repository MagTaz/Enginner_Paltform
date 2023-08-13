// ignore_for_file: dead_code

import 'package:engineers_app/Services/UserServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'EngineerHomePage.dart';
// import 'package:test1_app/NavBar.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

bool _isVisable = true;
bool _isVisable2 = true;
String _errorText = "";

class _SignupPageState extends State<SignupPage> {
  var _nameController = TextEditingController();
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _ConfirmpasswordController = TextEditingController();
  var _numberController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    setState(() {
      _errorText;
    });

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
                    height: height - 70,
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
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          const Text(
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 35,
                                color: Color.fromARGB(255, 23, 153, 110)),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          _errorText.isEmpty
                              ? Container()
                              : Text(
                                  _errorText,
                                  style: TextStyle(color: Colors.redAccent),
                                ),
                          TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(15),
                                hintText: ("Name"),
                                prefixIcon: Icon(Icons.account_box),
                                prefixIconColor:
                                    Color.fromARGB(255, 15, 93, 119),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 15, 93, 119),
                                        width: 2.5),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 15, 93, 119)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)))),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(15),
                                hintText: ("Email"),
                                prefixIcon: Icon(Icons.email),
                                prefixIconColor:
                                    Color.fromARGB(255, 15, 93, 119),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 15, 93, 119),
                                        width: 2.5),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 15, 93, 119)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)))),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _isVisable,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(15),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                hintText: ("Password"),
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
                                        color:
                                            Color.fromARGB(255, 15, 93, 119)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)))),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: _ConfirmpasswordController,
                            obscureText: _isVisable2,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(15),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                hintText: ("Confirm password"),
                                prefixIcon: const Icon(Icons.lock),
                                prefixIconColor:
                                    const Color.fromARGB(255, 15, 93, 119),
                                suffixIconColor:
                                    const Color.fromARGB(255, 15, 93, 119),
                                suffixIcon: IconButton(
                                  icon: _isVisable2
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      _isVisable2 = !_isVisable2;
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
                                        color:
                                            Color.fromARGB(255, 15, 93, 119)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)))),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: _numberController,
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(15),
                                hintText: ("Number"),
                                prefixIcon: Icon(Icons.account_box),
                                prefixIconColor:
                                    Color.fromARGB(255, 15, 93, 119),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 15, 93, 119),
                                        width: 2.5),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 15, 93, 119)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)))),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                  enableFeedback: true,
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color.fromARGB(255, 15, 93, 119))),
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return SignupPage();
                                }));
                              },
                              child: InkWell(
                                onTap: () async {
                                  if ((_ConfirmpasswordController.text ==
                                      _passwordController.text)&& _nameController.text.isNotEmpty&& _emailController.text.isNotEmpty&& _passwordController.text.isNotEmpty && _numberController.text.isNotEmpty) {
                                    await UserServices().SignUp(
                                        _emailController.text.trim(),
                                        _passwordController.text,
                                        _nameController.text.trim(),
                                        _numberController.text);
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EngineerHomePage()),
                                        ((route) => false));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor: Color.fromARGB(
                                                255, 23, 153, 110),
                                            content: Text(
                                              "You are signed up",
                                              style: TextStyle(fontSize: 15),
                                            )));
                                  }
                                  else if (_nameController.text.isEmpty ||_emailController.text.isEmpty ||_passwordController.text.isEmpty||_ConfirmpasswordController.text.isEmpty||_numberController.text.isEmpty ){
                                    setState(() {
                                      _errorText = "Please fill all fields ";
                                    });
                                  }
                                  else if (_ConfirmpasswordController.text !=
                                      _passwordController.text){
                                    setState(() {
                                      _errorText = "Confirm password does not match ";
                                    });
                                  }


                                  
                                },
                                child: Container(
                                    width: width,
                                    child: const Text(
                                      "Sign Up",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    )),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
