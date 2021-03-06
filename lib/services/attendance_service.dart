import 'package:barber_shop_control/dtos/attendance/attendance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference attendanceCollection =
      FirebaseFirestore.instance.collection("Attendances");

  add(Attendance attendance) {
    _firestore.collection("Attendances").add(
          attendance.toMap(),
        );
  }

  Stream<QuerySnapshot> getAttendanceList() {
    return attendanceCollection.snapshots();
  }

  Future<String> getAttendanceById(String id) async {
    var collection = _firestore.collection("Attendances");
    var docSnapshot = await collection.doc(id).get();
    Map<String, dynamic>? data = docSnapshot.data();
    return Future.value(data!['type']);
  }

  void updateAttendance(Attendance atten) async {
    await attendanceCollection.doc(atten.id).update(atten.toMap());
  }

  void deleteAttedance(String id) async {
    await attendanceCollection.doc(id).delete();
  }
}
