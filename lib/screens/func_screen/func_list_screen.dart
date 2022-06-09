import 'package:barber_shop_control/screens/func_screen/func_add_screen.dart';
import 'package:barber_shop_control/services/func_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:barber_shop_control/services/client_service.dart';


class FuncListScreen extends StatelessWidget {
  const FuncListScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
    FuncService funcService = FuncService();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Funcionários', style: TextStyle(),),
        backgroundColor: const Color.fromARGB(255, 1, 40, 71),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        tooltip: 'Adicinar Funcionário',
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const FuncAddScreen(),
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: funcService.getFuncList(),
          builder: (BuildContext context, snapshot) {
            if( !snapshot.hasData ){
              return const Center(
                child: CircularProgressIndicator(),
                );
            }
    
            if( snapshot.hasData && snapshot.data != null ){
              final List<DocumentSnapshot> docSnap = snapshot.data!.docs;
              return ListView.separated(
                separatorBuilder: (context, index) => 
                    const SizedBox(
                      height: 10,
                    ), 
                itemCount:  docSnap.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    style: ListTileStyle.list,
                    tileColor: index % 2 == 1
                        ? const Color.fromARGB(255, 36, 37, 38)
                        : const Color.fromARGB(255, 231, 220, 219),
                    title: Text(
                      docSnap[index].get('name'),
                      style: TextStyle(
                        color: index % 2 == 1 ? Colors.white : Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      docSnap[index].get('age').toString(),
                      style: TextStyle(
                        color: index % 2 == 1 ? Colors.white : Colors.black,
                      ),
                    ),
                     trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red,),
                      onPressed: () {
                        funcService.deleteFunc(docSnap[index].id );
                      },
                    ),
                    onTap: (){},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
    
                  );
                }, 
    
                );
            }else if (snapshot.connectionState == ConnectionState.done && snapshot.data == null){
              return Center(
                child: ListView (
                  children: const  [
                    Align(
                      alignment: AlignmentDirectional.center,
                      child: Text('Não há dados disponíveis'),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
    
          }, 
        ),
      ),
    );
  }
}