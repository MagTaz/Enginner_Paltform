import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engineers_app/Services/UserServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter/services.dart';

class ProjectDetailS extends StatefulWidget {
  const ProjectDetailS({super.key});

  @override
  State<ProjectDetailS> createState() => ProjectDetailSState();
}

class ProjectDetailSState extends State<ProjectDetailS> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final routeArg = ModalRoute.of(context)!.settings.arguments as Map;
    final String title = routeArg['title'];
    final String description = routeArg['description'];
    final String image = routeArg['image'];
    final String email = routeArg['email'];
    final String _type = routeArg['type'];

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 23, 153, 110),
                Color.fromARGB(255, 15, 93, 119)
              ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
            ),
          ),
          Container(
            height: height,
            width: width,
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 60),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FirebaseAuth.instance.currentUser?.email == email
                        ? IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        content: Text(
                                          "Do you want to delete this project?",
                                          textAlign: TextAlign.start,
                                        ),
                                        actions: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("No")),
                                              TextButton(
                                                  onPressed: () {
                                                    UserServices()
                                                        .deleteProject(
                                                            _type, image);
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Yes")),
                                            ],
                                          )
                                        ],
                                      ));
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                              size: 30,
                            ))
                        : Container(),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                FutureBuilder(
                    future: UserServices().getImage(image),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          height: 250,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              image: DecorationImage(
                                  image: NetworkImage(snapshot.data),
                                  fit: BoxFit.fitHeight)),
                        );
                      } else {
                        return Container(
                          height: 200,
                        );
                      }
                    }),
                SizedBox(
                  height: 30,
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontFamily: "LilitaOne"),
                  textAlign: TextAlign.center,
                ),
                const Divider(),
                Expanded(
                  child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10))),
                      child: SingleChildScrollView(
                        child: Text(
                          description,
                          style: TextStyle(
                              color: Color.fromARGB(255, 15, 93, 119),
                              fontSize: 16),
                          textAlign: TextAlign.start,
                        ),
                      )),
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        isDismissible: true,
                        isScrollControlled: true,
                        useRootNavigator: true,
                        context: context,
                        builder: (context) {
                          return Container(
                            height: height / 2,
                            width: width,
                            child: FutureBuilder(
                                future:
                                    UserServices().getEngineerDetails(email),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            topLeft: Radius.circular(20)),
                                        gradient: LinearGradient(
                                            colors: [
                                              Color.fromARGB(255, 31, 162, 206),
                                              Color.fromARGB(255, 15, 93, 119)
                                            ],
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter),
                                      ),
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        children: [
                                          
                                          SizedBox(
                                            height: 60,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.account_box,
                                                color: Colors.white
                                                    .withOpacity(0.8),
                                              ),
                                              Spacer(),
                                              Text(
                                                snapshot.data[0]["name"]
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "LilitaOne",
                                                    fontSize: 20),
                                              ),
                                              Spacer(),
                                            ],
                                          ),
                                          Divider(),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.email,
                                                color: Colors.white
                                                    .withOpacity(0.8),
                                              ),
                                              Spacer(),
                                              Text(
                                                snapshot.data[0]["email"]
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "LilitaOne",
                                                    fontSize: 20),
                                              ),
                                             SizedBox(width: width/9,),
                                              IconButton(onPressed: (){
                                                final _value = ClipboardData(text: snapshot.data[0]["email"]);
                                                Clipboard.setData(_value);
                                                ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar( 
                                            content: Text(
                                              "The email has been copied",
                                              style: TextStyle(fontSize: 15),
                                            )));
                                            Navigator.pop(context);

                                              }, icon: Icon(Icons.copy,color: Colors.white.withOpacity(0.6),))
                                            ],
                                          ),
                                          Divider(),
                                          Spacer(),
                                          ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Color(0xFFFBB13C)),
                                              ),
                                              onPressed: () async {
                                                Uri dialnumber = Uri(
                                                    scheme: "tel",
                                                    path: snapshot.data[0]["number"]
                                                        .toString());
                                                // FlutterPhoneDirectCaller.callNumber("0501092021");
                                                Navigator.pop(context);
                                                await launchUrl(dialnumber);
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.call,
                                                    color: Color.fromARGB(
                                                            255, 15, 93, 119)
                                                        .withOpacity(0.8),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  // Text("call:   ",style: TextStyle(color: Color.fromARGB(255, 15, 93, 119).withOpacity(0.8),fontSize: 16),),
                                                  Text(
                                                    snapshot.data[0]["number"]
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 15, 93, 119),
                                                        fontSize: 18),
                                                  ),
                                                ],
                                              )),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                }),
                          );
                        });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        height: 50,
                        child: Text(
                          "Contact the engineer",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                      Icon(
                        Icons.arrow_drop_up_outlined,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
}
