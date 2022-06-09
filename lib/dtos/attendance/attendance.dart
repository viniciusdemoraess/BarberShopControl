import 'package:barber_shop_control/dtos/client/client.dart';
import 'package:barber_shop_control/dtos/func/func.dart';

class Attendance {
  late final String? id;

  late final String? type;

  // late final Date date; 

  // late final Time time;

  late final String? refClient;

  late final String? refFunc;

  Attendance({
    this.type, this.refClient, this.refFunc}
  );

  //convert object MAP in Client
  Attendance.fromMap(Map<String, dynamic> map)
    : type = map["type"],
      refClient = map["refClient"],
      refFunc = map["refFunc"];

  Map<String, dynamic> toMap(){
    return {
      'type': type,
      'refClient': refClient,
      'refFunc': refFunc
    };
  }

}