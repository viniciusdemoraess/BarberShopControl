import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserLocal {
  String? id;
  String? name;
  String? email;
  String? password;
  String? confirmPassword;
  bool? admin = false;

  UserLocal({
    this.id,
    this.name,
    this.email,
    this.password,
    this.confirmPassword,
    this.admin,
  });

  UserLocal.fromDocument(DocumentSnapshot doc){
    id = doc.id;
    name = doc.get('name') as String;
    email = doc.get('email') as String;   
  }

  DocumentReference get firestoreReference => FirebaseFirestore.instance.doc('users/$id');

  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      'name': name,
      'email': email
    };
  }

  Future<void> saveData() async {
    await firestoreReference.set(toMap());
  }


  factory UserLocal.fromMap(Map<String, dynamic> map) {
    return UserLocal(
      id: map['id'],
      name: map['name'],
      email: map['email'],
    );
  }

}