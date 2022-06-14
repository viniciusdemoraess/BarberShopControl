import 'package:barber_shop_control/dtos/func/func.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FuncService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference funcCollection = FirebaseFirestore.instance.collection("Funcionarys");
  add(Func func){
    _firestore.collection("Funcionarys").add(
      func.toMap(), 
      );
  }

  Stream<QuerySnapshot> getFuncList(){
    return funcCollection.snapshots();
  }

  Future<String> getById(String id) async {
    var collection = _firestore.collection('Funcionarys');
    var docSnapshot = await collection.doc(id).get();
    Map<String, dynamic>? data = docSnapshot.data();
    // return '${data!['area']}';
    return Future.value(data?['name']);
  }



  
  void updateFunc(Func func) async {
    await funcCollection.doc(func.id).update(func.toMap());
  }

  void deleteFunc(String id) async {
    await funcCollection.doc(id).delete();
  }

}