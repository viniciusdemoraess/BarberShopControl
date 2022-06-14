import 'package:barber_shop_control/components/date_picker.dart';
import 'package:barber_shop_control/dtos/attendance/attendance.dart';
import 'package:barber_shop_control/dtos/func/func.dart';
import 'package:barber_shop_control/dtos/user/user_local.dart';
import 'package:barber_shop_control/services/attendance_service.dart';
import 'package:barber_shop_control/services/func_service.dart';
import 'package:barber_shop_control/services/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AttendanceAddScreen extends StatefulWidget {
  final UserLocal? userLocal;

  const AttendanceAddScreen({this.userLocal,Key? key}) : super(key: key);

  @override
  State<AttendanceAddScreen> createState() => _AttendanceAddScreenState();
}

class _AttendanceAddScreenState extends State<AttendanceAddScreen> {
  TextEditingController typeController = TextEditingController();
  TextEditingController clientController = TextEditingController();
  TextEditingController funcController = TextEditingController();

  FuncService funcService = FuncService();

  var _selectedFunc;

  var _selectedService;
  late DateTime serviceDate;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> serviceItem = [];
    List<String> types = ['Corte de Cabelo', 'Pintar Cabelo', 'Barba'];
    for (var i in types) {
      serviceItem.add(
        DropdownMenuItem<String>(
          child: Text(
            i,
            style: const TextStyle(
              color: Color(0xff1c313a),
            ),
          ),
          value: i,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Agendar Horário')),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              shadowColor: Colors.white,
              shape: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const Text(
                      'Agendar um Serviço',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StreamBuilder<QuerySnapshot>(
                            stream: funcService.getFuncList(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else {
                                List<DropdownMenuItem<String>> funcItems = [];
                                for (int i = 0;
                                    i < snapshot.data!.docs.length;
                                    i++) {
                                  DocumentSnapshot snapDoc =
                                      snapshot.data!.docs[i];
                                  funcItems.add(
                                    DropdownMenuItem<String>(
                                      child: Text(
                                        snapDoc.get('name'),
                                        style: const TextStyle(
                                          color: Color(0xff1c313a),
                                        ),
                                      ),
                                      value: snapDoc.id,
                                    ),
                                  );
                                }
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text('Funcionário'),
                                    const SizedBox(width: 5),
                                    DropdownButton(
                                      value: _selectedFunc,
                                      items: funcItems,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedFunc = value;
                                        });
                                        ScaffoldMessenger(
                                          child: SnackBar(
                                              backgroundColor: Colors.red,
                                              content: Text(
                                                  'Ambiente atual $value')),
                                        );
                                      },
                                      hint: const Text(
                                        'Funcionários',
                                        style: TextStyle(
                                          color: Color(
                                            0xff1c313a,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text('Serviço'),
                              const SizedBox(width: 5),
                              DropdownButton(
                                value: _selectedService,
                                items: serviceItem,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedService = value;
                                  });
                                  ScaffoldMessenger(
                                    child: SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text('Ambiente atual $value')),
                                  );
                                },
                                hint: const Text(
                                  'Serviços',
                                  style: TextStyle(
                                    color: Color(
                                      0xff1c313a,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          DatePicker(
                            name: "Dia da reserva",
                            onChanged: (date) {
                              serviceDate = date;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Informe a data da reserva';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  //acess services of persistence
                                  AttendanceService service =
                                      AttendanceService();
                                  Attendance attendance = Attendance(
                                      type: _selectedService,
                                      date: serviceDate,
                                      refFunc:
                                          _selectedFunc,
                                      refClient: widget.userLocal?.id); //,clientController.text , funcController.text

                                  service.add(attendance);
                                  Navigator.of(context).pop();
                                }
                              },
                              child: const Text("Agendar"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
