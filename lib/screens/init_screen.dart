import 'package:barber_shop_control/services/client_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class InitiScreen extends StatelessWidget {
  const InitiScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ClientService clientService = ClientService();
    return Material(
      child: StreamBuilder<QuerySnapshot>(
          stream: clientService.getClientList(),
          builder: (BuildContext ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              List<DocumentSnapshot> docSnap = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(28.0),
                child: ListView.separated(
                  itemBuilder: (ctx, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(docSnap[index].get('name')),
                            Text(docSnap[index].get('age').toString()),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return const SizedBox(
                      height: 5,
                    );
                  },
                  itemCount: docSnap.length,
                ),
              );
            } else {
              return const Center(child: Text('Dados Indispoiveis!'));
            }
          }),
    );
  }
}
