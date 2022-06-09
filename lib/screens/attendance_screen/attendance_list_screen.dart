import 'package:barber_shop_control/dtos/func/func.dart';
import 'package:barber_shop_control/services/attendance_service.dart';
import 'package:barber_shop_control/services/client_service.dart';
import 'package:barber_shop_control/services/func_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AttendanceListScreen extends StatefulWidget {
  const AttendanceListScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceListScreen> createState() => _AttendanceListScreenState();
}

class _AttendanceListScreenState extends State<AttendanceListScreen> {
  @override
  Widget build(BuildContext context) {
    AttendanceService attedanceService = AttendanceService();

    String nameFun;

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: attedanceService.getAttendanceList(),
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
                    FuncService funcService = FuncService();
                    funcService
                        .getById(docSnap[index].get('refFunc'))
                        .then((value) {
                      setState(() {
                        nameFun = value;
                      });
                    });

                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FutureBuilder(
                                future: funcService
                                    .getById(docSnap[index].get('refFunc')),
                                builder: (BuildContext context, AsyncSnapshot<String> text) {
                                  return text.hasData ? Text(text.data!) : Container();
                                }),
                            // Text(nameFun),
                            Text(docSnap[index].get('type').toString()),
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
              return const Center(child: Text('Dados Indisponíveis!'));
            }
          }),
    );
  }
}
