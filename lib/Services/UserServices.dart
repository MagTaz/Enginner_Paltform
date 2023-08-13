import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/material.dart';

class UserServices {
  final _fireStore = FirebaseFirestore.instance;

  var downloadURL;
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final _firstore = FirebaseFirestore.instance;
  String? uploadURL;
  Future Login(final String email, final String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future SignUp(final String email, final String password, final String name,
      final String number) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    try {
      await _firstore
          .collection("Users")
          .add({"name": name, "email": email, "number": number});

      Login(email, password);
    } catch (e) {}
  }

  Future addProject(String type, String email, String title, String description,
      String imageName, var filePath) async {
    try {
      await _firstore.collection(type).add({
        "title": title,
        "email": email,
        "description": description,
        "imageName": imageName
      });
      uploadFile(filePath, imageName);
    } catch (e) {}
  }

  void uploadFile<Future>(String filePath, String fileName) async {
    File file = File(filePath);

    try {
      await storage.ref("Projects/$fileName").putFile(file);
      uploadURL = await FirebaseStorage.instance
          .ref()
          .child("Projects")
          .child(fileName)
          .getDownloadURL();
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  Future getImage(String name) async {
    try {
      downloadURL = await FirebaseStorage.instance
          .ref()
          .child("Projects")
          .child(name)
          .getDownloadURL();

      return downloadURL;
    } catch (e) {}
  }

  getNumber(String email) async {
    await for (var projects in _fireStore.collection("Users").snapshots()) {
      for (var project in projects.docs) {
        if (project["email"] == email) {
          return project["number"].toString();
        }
      }
    }
  }

  Future deleteProject(String type, String imageName) async {
    try {
      await for (var projects in _fireStore.collection(type).snapshots()) {
        for (var project in projects.docs) {
          if (imageName == project["imageName"]) {
            _fireStore.collection(type).doc(project.id).delete();
            await FirebaseStorage.instance
                .ref()
                .child("Projects")
                .child(imageName)
                .delete();
          }
        }
      }
    } catch (e) {}
  }

  Future getEngineerDetails(String email) async {
    List _projectsList = [];
  var  projects =await _fireStore.collection("Users").get();
      for (var project in projects.docs) {
        if (email == project["email"]) {
           _projectsList.add(
          {
            "name": project["name"],
            "email": project["email"],
            "number": project["number"],
          },
        );
        }
       
      
    }
    return _projectsList;
  }
}
