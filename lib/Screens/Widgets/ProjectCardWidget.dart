import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

var downloadURL;

class PorjectCard extends StatefulWidget {
  String title;
  String image;
  String description;
  String email;
  String type;

  PorjectCard(this.title, this.image, this.description,this.email, this.type);

  @override
  State<PorjectCard> createState() => _PorjectCardState();
}

class _PorjectCardState extends State<PorjectCard> {
  @override
  Widget build(BuildContext context) {
    setState(() {
      getImage(widget.image);
    });

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed("/ProjectDetails", arguments: {
          "image": widget.image,
          "description": widget.description,
          "title": widget.title,
          "email":widget.email,
          "type" : widget.type
        });
      },
      child: Container(
        height: height / 4,
        width: width,
        child: Stack(children: [
          FutureBuilder(
              future: getImage(widget.image),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 2,
                              color: Colors.black45)
                        ],
                        image: DecorationImage(
                            image: NetworkImage(snapshot.data),
                            fit: BoxFit.cover,
                            opacity: 0.8),
                        color: Color.fromARGB(255, 29, 156, 199)),
                  );
                } else {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 23, 153, 110),
                  ));
                }
              }),
          Container(
            margin: EdgeInsets.all(20),
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Text(
                  widget.title,
                  style: TextStyle(
                      color: Color.fromARGB(255, 23, 153, 110),
                      fontSize: 16,
                      fontFamily: "LilitaOne"),
                )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              width: width,
              color: Colors.black45,
              child: SingleChildScrollView(
                  child: Text(
                widget.description,
                style: TextStyle(color: Colors.white, fontSize: 14),
                textAlign: TextAlign.center,
              )),
            ),
          )
        ]),
      ),
    );
  }

  Future getImage(String name) async {
    try {
      downloadURL = await FirebaseStorage.instance
          .ref()
          .child("Projects")
          .child(name)
          .getDownloadURL();

      return downloadURL;
    } catch (e) {
      
    }
  }
}
