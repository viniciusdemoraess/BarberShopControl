import 'package:barber_shop_control/dtos/client/client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClientService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference clientCollection =
      FirebaseFirestore.instance.collection("Clients");

  add(Client client) {
    _firestore.collection("Clients").add(
          client.toMap(),
        );
  }

  Stream<QuerySnapshot> getClientList() {
    return clientCollection.snapshots();
  }

  void updateClient(Client client) async {
    await clientCollection.doc(client.id).update(client.toMap());
  }

  void deleteClient(String id) async {
    await clientCollection.doc(id).delete();
  }
}
