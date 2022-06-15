import 'package:barber_shop_control/dtos/user/user_local.dart';
import 'package:barber_shop_control/screens/attendance_screen/attendance_add_screen.dart';
import 'package:barber_shop_control/services/attendance_service.dart';
import 'package:barber_shop_control/services/func_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceListScreen extends StatefulWidget {
  final UserLocal? userLocal;
  const AttendanceListScreen({this.userLocal, Key? key}) : super(key: key);

  @override
  State<AttendanceListScreen> createState() => _AttendanceListScreenState();
}

class _AttendanceListScreenState extends State<AttendanceListScreen> {
  @override
  Widget build(BuildContext context) {
    AttendanceService attedanceService = AttendanceService();

    String nameFun;

    return Card(
      color: const Color.fromARGB(255, 202, 235, 248),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: StreamBuilder<QuerySnapshot>(
          stream: attedanceService.getAttendanceList(),
          builder: (BuildContext ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              List<DocumentSnapshot> docSnap = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) {
                    FuncService funcService = FuncService();
                    funcService
                        .getById(docSnap[index].get('refFunc'))
                        .then((value) {
                      setState(() {
                        nameFun = value;
                      });
                    });
                    DateTime _selectedDate = (docSnap[index].get('date')).toDate();
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Color.fromARGB(255, 190, 201, 209),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                            children: [
                              Expanded(
                                child: FutureBuilder(
                                    future: funcService
                                        .getById(docSnap[index].get('refFunc')),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<String> text) {
                                      return text.hasData
                                          ? Text(text.data!)
                                          : Container();
                                    }),
                              ),
                              // Text(nameFun),
                              Expanded(
                                  child: Text(docSnap[index].get('type').toString())),
                              Expanded(
                                  child: Text(DateFormat('dd-MM-yy').format(_selectedDate)),),
                              Expanded(
                                  child: IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        attedanceService
                                            .deleteAttedance(docSnap[index].id);
                                      })),
                            ],
                          ),
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
