import 'package:barber_shop_control/screens/attendance_screen/attendance_list_screen.dart';
import 'package:barber_shop_control/screens/dashboard_screen/dashboard_screen.dart';
import 'package:barber_shop_control/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPage = 0;
  List<Widget> pageList = [];

  @override
  void initState() {
    pageList.add(const AttendanceListScreen());
    pageList.add(const DashboardScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserService>(builder: (_, userService, __) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
              child: Text(
            'Olá! ${userService.userLocal?.name}',
            style: const TextStyle(),
          )),
          backgroundColor: const Color.fromARGB(255, 1, 40, 71),
        ),
        body: IndexedStack(
          children: pageList,
          index: _selectedPage,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 1, 40, 71),
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.white,
          currentIndex: _selectedPage,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Início',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Menu',
            ),
          ],
        ),
      );
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
  }
}
