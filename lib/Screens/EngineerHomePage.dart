import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engineers_app/Screens/HomePage.dart';
import 'package:engineers_app/Screens/Widgets/ProjectCardWidget.dart';
import 'package:engineers_app/Screens/userProjects.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'AddProjectPage.dart';

class EngineerHomePage extends StatefulWidget {
  const EngineerHomePage({super.key});

  @override
  State<EngineerHomePage> createState() => _EngineerHomePageState();
}

Color buttom1Color = Color.fromARGB(255, 29, 156, 199).withOpacity(0.5);
Color buttom2Color = Colors.transparent;
Color buttom3Color = Colors.transparent;
var closeSpeedDial = ValueNotifier(true);
var selectedItem = "IT";
String _typeOfProject = "IT";
List _projectsList = [];
var downloadURL;
final _fireStore = FirebaseFirestore.instance;

class _EngineerHomePageState extends State<EngineerHomePage> {
 

  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance.currentUser!;
    setState(() {
      getProjects(_typeOfProject);
    });
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: FirebaseAuth.instance.currentUser != null
          ? SpeedDial(
              openCloseDial: closeSpeedDial,
              overlayColor: Color.fromARGB(255, 23, 153, 110),
              overlayOpacity: 0.4,
              spaceBetweenChildren: 15,
              backgroundColor: Color.fromARGB(255, 23, 153, 110),
              animatedIcon: AnimatedIcons.menu_close,
              children: [
                SpeedDialChild(
                    shape: CircleBorder(),
                    backgroundColor: Color.fromARGB(255, 15, 93, 119),
                    child: IconButton(
                      icon: Icon(Icons.add, color: Colors.white),
                      onPressed: () {
                        closeSpeedDial.value = false;

                        showModalBottomSheet(
                            isDismissible: true,
                            isScrollControlled: true,
                            useRootNavigator: true,
                            context: context,
                            builder: (context) {
                              return AddProject();
                            });
                      },
                    ),
                    label: "Add Project"),
                SpeedDialChild(
                    shape: CircleBorder(),
                    backgroundColor: Color.fromARGB(255, 15, 93, 119),
                    child: IconButton(
                      icon: Icon(
                        Icons.my_library_books,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        closeSpeedDial.value = false;
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                            return UserProjects();
                          }));
                      },
                    ),
                    label: "My projects"),
                SpeedDialChild(
                    shape: CircleBorder(),
                    backgroundColor: Color.fromARGB(255, 15, 93, 119),
                    child: IconButton(
                      icon: Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                            ((route) => false));
                             ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                           
                            content: Text("You are logged out",style: TextStyle(fontSize: 15),))
                        );
                      },
                    ),
                    label: "Sign Out"),
              ],
            )
          : null,
      backgroundColor: Colors.white.withOpacity(0.8),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                width: width,
                height: height / 4,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2, spreadRadius: 3, color: Colors.black38)
                    ],
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 23, 153, 110),
                      Color.fromARGB(255, 15, 93, 119)
                    ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                                width: 130,
                                child: Image.asset("assets/images/logo.png")),
                          ),
                        ],
                      ),
                      Container(
                        width: width,
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  buttom1Color =
                                      Color.fromARGB(255, 29, 156, 199)
                                          .withOpacity(0.5);
                                  buttom2Color = Colors.transparent;
                                  buttom3Color = Colors.transparent;
                                  _typeOfProject = "IT";
                                  getProjects(_typeOfProject);
                                });
                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 5),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      color: buttom1Color),
                                  child: Text(
                                    "IT",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  )),
                            ),
                            Container(
                              height: 22,
                              child: VerticalDivider(
                                thickness: 1,
                                color: Color.fromARGB(255, 23, 153, 110),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  buttom1Color = Colors.transparent;
                                  buttom2Color =
                                      Color.fromARGB(255, 29, 156, 199)
                                          .withOpacity(0.5);
                                  buttom3Color = Colors.transparent;

                                  _typeOfProject = "Structural engineer";
                                  getProjects(_typeOfProject);
                                });
                              },
                              child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      color: buttom2Color),
                                  child: Text(
                                    "Structural engineer",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  )),
                            ),
                            Container(
                              height: 22,
                              child: VerticalDivider(
                                thickness: 1,
                                color: Color.fromARGB(255, 23, 153, 110),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  buttom1Color = Colors.transparent;
                                  buttom2Color = Colors.transparent;
                                  buttom3Color =
                                      Color.fromARGB(255, 29, 156, 199)
                                          .withOpacity(0.5);
                                  _typeOfProject = "Electrical engineer";
                                  getProjects(_typeOfProject);
                                });
                              },
                              child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      color: buttom3Color),
                                  child: Text(
                                    "Electrical engineer",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  )),
                            ),
                          ],
                        ),
                      )
                    ]),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: height * 3 / 4 - 100,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: StreamBuilder(
                    stream: _fireStore.collection(_typeOfProject).snapshots(),
                    builder: (context, snapshot1) {
                      return ListView.builder(
                        itemCount: _projectsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return PorjectCard(
                              _projectsList[index]["title"],
                              _projectsList[index]["imageName"],
                              _projectsList[index]["description"],
                             _projectsList[index]["email"],
                             _typeOfProject );
                        },
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  getProjects(String type) async {
    await for (var projects in _fireStore.collection(type).snapshots()) {
      _projectsList = [];

      for (var project in projects.docs) {
        _projectsList.add(
          {
            "title": project["title"],
            "imageName": project["imageName"],
            "email": project["email"],
            "description": project["description"]
          },
        );
      }
    }
  }
}
