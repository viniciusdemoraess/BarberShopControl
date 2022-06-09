import 'package:barber_shop_control/dtos/items_dashboard.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  ItemsDashboard item1 = ItemsDashboard(
      "Adicionar Cliente", "Clientes", "assets/images/addPerson.png");

  ItemsDashboard item2 = ItemsDashboard(
      "Clientes", "Registro de Clientes", "assets/images/list.jpg");

  ItemsDashboard item3 = ItemsDashboard(
      "Adicionar Funcionário", "Funcionários", "assets/images/addFunc.png");

  ItemsDashboard item4 = ItemsDashboard(
      "Funcionários", "Registro de Funcionários", "assets/images/funcionario.png");

  ItemsDashboard item5 = ItemsDashboard(
      "Agendar", "Registro de Horários", "assets/images/calendario.png");

  @override
  Widget build(BuildContext context) {
    List<ItemsDashboard> myList = [item1, item2, item3, item4, item5];

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
        itemCount: myList.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (BuildContext ctx, index) {
          return GestureDetector(
            onTap: () => callUnit(ctx, index),
            child: Container(
              decoration: BoxDecoration(
                  color:  Color.fromARGB(255, 255, 255, 255),
                  //const Color.fromARGB(255, 44, 50, 49)
                   
                  borderRadius: BorderRadius.circular(14)),
              child: Column(
                children: [
                  // Container(
                  //   decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //           image: AssetImage(myList[index].image),
                  //           fit: BoxFit.contain ),
                  //   ),
                  // ),
                  const SizedBox(height: 10),
                  Image.asset(myList[index].image, width: 60, height: 60,),
                  const SizedBox(height: 10),
                  Text(myList[index].title, style: const TextStyle( fontWeight: FontWeight.bold, color: Color.fromARGB(255, 91, 147, 193)),),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  callUnit(BuildContext context, int index) {
    if (index == 0) {
      Navigator.of(context).pushNamed("/addClient");
    }

    if (index == 1) {
      Navigator.of(context).pushNamed("/listClient");
    }

    if (index == 2) {
      Navigator.of(context).pushNamed("/addFunc");
    }

    if (index == 3) {
      Navigator.of(context).pushNamed("/listFunc");
    }

    if (index == 4) {
      Navigator.of(context).pushNamed("/agend");
    }
  }
}
