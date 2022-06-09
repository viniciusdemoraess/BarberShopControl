import 'package:barber_shop_control/screens/client_screen/client_add_screen.dart';
import 'package:barber_shop_control/screens/client_screen/client_list_screen.dart';
import 'package:barber_shop_control/screens/func_screen/func_list_screen.dart';
import 'package:barber_shop_control/screens/func_screen/func_add_screen.dart';
import 'package:barber_shop_control/screens/attendance_screen/attendance_add_screen.dart';



import 'package:barber_shop_control/screens/home_screen/home_screen.dart';
import 'package:barber_shop_control/screens/login/login_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter - Barber',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 232, 228, 228),
        appBarTheme: const AppBarTheme(
          backgroundColor:  Color.fromARGB(255, 1, 40, 71),
        ) ,
      ) ,
      
      initialRoute: '/login',
      routes: {
        '/': (context) =>  const HomeScreen(),
        '/addClient': (context) => const ClientAddScreen(),
        '/listClient':(context) =>  const ClientListScreen(),
        '/addFunc': (context) => const FuncAddScreen(),
        '/listFunc': (context) => const FuncListScreen(),
        '/agend': (context) => const AttendanceAddScreen(),
        '/login': (context) => const LoginScreen(),

      },
    );
  }
}
