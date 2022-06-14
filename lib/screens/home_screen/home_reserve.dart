import 'package:barber_shop_control/dtos/user/user_local.dart';
import 'package:barber_shop_control/screens/attendance_screen/attendance_add_screen.dart';
import 'package:barber_shop_control/screens/attendance_screen/attendance_list_screen.dart';
import 'package:barber_shop_control/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class HomeReserveScreen extends StatefulWidget {
  final UserLocal? userLocal;
  const HomeReserveScreen({this.userLocal, Key? key}) : super(key: key);

  @override
  State<HomeReserveScreen> createState() => _HomeReserveScreenState();
}

class _HomeReserveScreenState extends State<HomeReserveScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserService>(builder: (_, userService, __) {
      return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            const Text(
              'Minha Agenda',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // banner(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 350,
                    child: Card(
                      elevation: 2,
                      child: SizedBox(
                        child: Column(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              // width: MediaQuery.of(context).size.width * .8,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey,
                                    width: 1.0,
                                    style: BorderStyle.none), //Border.all

                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  topRight: Radius.circular(5.0),
                                  bottomLeft: Radius.circular(5.0),
                                  bottomRight: Radius.circular(5.0),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          primary: Colors.blue,
                                          backgroundColor:
                                              const Color(0xFFEFF7F6),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AttendanceAddScreen(
                                                          userLocal: userService
                                                              .userLocal)));
                                        },
                                        child: const Text("Solicitar Reserva")),
                                  ),
                                  const SizedBox(width: 5),
                                ],
                              ),
                            ),
                            Expanded(
                                child: AttendanceListScreen(
                                    userLocal: userService.userLocal)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
