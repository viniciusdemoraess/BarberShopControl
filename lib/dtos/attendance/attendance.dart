
import 'package:cloud_firestore/cloud_firestore.dart';

class Attendance {
  late final String? id;

  late final String? type;

  late final DateTime? date; 


  late final String? refClient;

  late final String? refFunc;

  Attendance({
    this.type, this.date, this.refClient, this.refFunc}
  );

  //convert object MAP in Client
  Attendance.fromMap(Map<String, dynamic> map)
    : type = map["type"],
      refClient = map["refClient"],
      refFunc = map["refFunc"],
      date = (map["date"] as Timestamp).toDate();

  Map<String, dynamic> toMap(){
    return {
      'type': type,
      'refClient': refClient,
      'refFunc': refFunc,
      'date': date,
    };
  }

}