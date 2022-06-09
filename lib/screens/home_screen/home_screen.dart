import 'package:barber_shop_control/screens/attendance_screen/attendance_list_screen.dart';
import 'package:barber_shop_control/screens/client_screen/client_add_screen.dart';
import 'package:barber_shop_control/screens/client_screen/client_list_screen.dart';
import 'package:barber_shop_control/screens/dashboard_screen/dashboard_screen.dart';
import 'package:barber_shop_control/screens/init_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

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
    return Scaffold(
      appBar: AppBar(
         automaticallyImplyLeading: false,
        title: const Center(child:  Text('BarBerShop', style: TextStyle(),)),
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
  }

  void _onItemTapped(int index){
    setState((){
    _selectedPage = index;
    });
  }

}