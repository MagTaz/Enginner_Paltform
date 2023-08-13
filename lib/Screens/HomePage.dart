import 'package:engineers_app/Screens/EngineerHomePage.dart';
import 'package:engineers_app/Screens/Login_page.dart';
import 'package:flutter/material.dart';
// import 'package:test1_app/NavBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(5),
        height: height,
        width: width,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 23, 153, 110),
          
          Color.fromARGB(255, 15, 93, 119)
        ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 100,
                        child: Image(image: AssetImage("assets/images/logo.png"))),
                      Text("Enginners Platform",style: TextStyle(fontSize: 40,color: Colors.white),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (){
                           Navigator.of(context).push(MaterialPageRoute(builder: (context){
                            return EngineerHomePage();
                          }));
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: width / 2.2,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black38,
                                    spreadRadius: 5,
                                    blurRadius: 15)
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(90))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.content_paste_search,color: Color.fromARGB(255, 23, 153, 110),),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Search for Projects",
                                style: TextStyle(fontSize: 14,color: Color.fromARGB(255, 23, 153, 110), fontWeight: FontWeight.bold,
                              ))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context){
                            return LoginPage();
                          }));
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: width / 2.4,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black38,
                                    spreadRadius: 5,
                                    blurRadius: 15)
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(90))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.engineering,color: Color.fromARGB(255, 15, 93, 119),),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "I am an Engineer",
                                style: TextStyle(fontSize: 14,color: Color.fromARGB(255, 15, 93, 119),fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
