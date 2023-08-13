import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:engineers_app/Screens/Widgets/ProjectCardWidget.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProjects extends StatefulWidget {
  const UserProjects({super.key});

  @override
  State<UserProjects> createState() => _UserProjectsState();
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
final _fireStore2 = FirebaseFirestore.instance;
final _fireStore3 = FirebaseFirestore.instance;
final user = FirebaseAuth.instance.currentUser!;

class _UserProjectsState extends State<UserProjects> {
  @override
  void initState() {
    getMyProjects(user.email.toString());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      getMyProjects(user.email.toString());
    });

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 15, 93, 119),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                width: width,
                height: 70,
                decoration: BoxDecoration(
                    boxShadow: [],
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 15, 93, 119),
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
                              width: width,
                              child: Text(
                                "My projects",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontFamily: "LilitaOne"),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: height * 3 / 4  ,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: StreamBuilder(
                    stream: _fireStore
                        .collection("Structural engineer")
                        .snapshots(),
                    builder: (context, snapshot1) {
                      return ListView.builder(
                        itemCount: _projectsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return PorjectCard(
                              _projectsList[index]["title"],
                              _projectsList[index]["imageName"],
                              _projectsList[index]["description"],
                              _projectsList[index]["email"],
                              _typeOfProject);
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

  Future getMyProjects(String email) async {
    _projectsList = [];
    String _projectIT = "IT";
   

    var projectsIT = await _fireStore.collection(_projectIT).get();
    for (var project in projectsIT.docs) {
      if (email == project["email"]) {
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
    var projectsStructuralengineer = await _fireStore.collection("Structural engineer").get();
    for (var project in projectsStructuralengineer.docs) {
      if (email == project["email"]) {
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
    var projectsElectricalengineer = await _fireStore.collection("Electrical engineer").get();
    for (var project in projectsElectricalengineer.docs) {
      if (email == project["email"]) {
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
