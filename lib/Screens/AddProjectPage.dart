import 'dart:io';

import 'package:engineers_app/Services/UserServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProject extends StatefulWidget {
  const AddProject({super.key});

  @override
  State<AddProject> createState() => _AddProjectState();
}

File? _selectedImage;
var selectedItem;
String _errorText = "";

class _AddProjectState extends State<AddProject> {
  List<String> projectType = [
    "IT",
    "Structural engineer",
    "Electrical engineer"
  ];
  var _TitleController = TextEditingController();
  var _DescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    @override
    void dispose() {
      _selectedImage == "";
      super.dispose();
    }

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(
          top: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom,
          right: 15,
          left: 15),
      height: height - 70,
      width: width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Add Project",
              style: TextStyle(
                  color: Color.fromARGB(255, 15, 93, 119),
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 50,
            ),
            _errorText.isEmpty
                ? Container()
                : Text(
                    _errorText,
                    style: TextStyle(color: Colors.redAccent),
                  ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 2),
                        color: Colors.black45)
                  ],
                  color: Color.fromARGB(255, 23, 153, 110),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: DropdownButton(
                  enableFeedback: true,
                  alignment: Alignment.center,
                  dropdownColor: Color.fromARGB(255, 23, 153, 110),
                  style: TextStyle(color: Colors.white),
                  hint: Text(
                    "Choose type of project",
                    style: TextStyle(color: Colors.white60),
                  ),
                  iconEnabledColor: Colors.white70,
                  items: projectType
                      .map((value) => DropdownMenuItem(
                            enabled: true,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(value),
                                Divider(
                                  color: Colors.white24,
                                ),
                              ],
                            ),
                            value: value,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(
                      () {
                        selectedItem = value.toString();
                      },
                    );
                  },
                  value: selectedItem),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: width / 12),
                child: TextFormField(
                  controller: _TitleController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 23, 153, 110),
                        ),
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 23, 153, 110),
                            width: 2.5),
                      ),
                      labelText: "Title",
                      hintText: "Enter the Title",
                      hintStyle: TextStyle(),
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 23, 153, 110))),
                )),
            SizedBox(
              height: 50,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: width / 12),
                child: TextFormField(
                  controller: _DescriptionController,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 23, 153, 110),
                            width: 2.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 23, 153, 110),
                        ),
                      ),
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 23, 153, 110)),
                      labelText: "Description",
                      hintText: "Enter the description of the project",
                      hintStyle: TextStyle()),
                )),
            SizedBox(
              height: 10,
            ),
            _selectedImage != null
                ? Container(width: 60, child: Image.file(_selectedImage!))
                : Container(),
            Container(
              child: TextButton(
                  onPressed: () {
                    pickProjectImage();
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(60)),
                        color:
                            Color.fromARGB(255, 15, 93, 119).withOpacity(0.2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_a_photo),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Add a photo"),
                      ],
                    ),
                  )),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              width: width,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 23, 153, 110))),
                  onPressed: () {
                    if (_selectedImage == null || _TitleController.text.isEmpty || _DescriptionController.text.isEmpty || selectedItem == null) {
                      setState(() {
                        _errorText = "Fill all fields";
                      });
                    } else {
                      UserServices().addProject(
                        selectedItem,
                        (FirebaseAuth.instance.currentUser!.email).toString(),
                        _TitleController.text,
                        _DescriptionController.text,
                        ("${FirebaseAuth.instance.currentUser!.uid}${_TitleController.text}"),
                        _selectedImage!.path);
                    Navigator.pop(context);
                    
                    }



                    
                    

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Color.fromARGB(255, 23, 153, 110),
                        content: Text(
                          "Your project has been added",
                          style: TextStyle(fontSize: 15),
                        )));
                  },
                  child: Text(
                    "Save the project",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

  Future pickProjectImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (_selectedImage != null) {
      Image.file(_selectedImage!);
    }

    setState(() {
      try {
        _selectedImage = File(image!.path);
      } catch (e) {}

      print(_selectedImage);
    });
  }
}
