import 'package:flutter/material.dart';

class ClientAddDialog extends StatefulWidget {
  const ClientAddDialog({Key? key}) : super(key: key);

  @override
  State<ClientAddDialog> createState() => _ClientAddDialogState();
}

class _ClientAddDialogState extends State<ClientAddDialog> {
  String nameClient = '';
  String ageClient = '';

  //ADICIONAR SERVICE E OBJETO

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Adicionar Cliente'),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
              autofocus: true,
              onChanged: (text) => nameClient = text,
            ),
            RadioListTile(
                title: const Text('Disponivel'),
                value: 'd',
                groupValue: ageClient,
                onChanged: (value) {
                  setState(() {
                    ageClient = (value ?? ' ') as String;
                  });
                }),
            RadioListTile(
                title: const Text('Indisponivel'),
                value: 'i',
                groupValue: ageClient,
                onChanged: (value) {
                  setState(() {
                    ageClient = (value ?? ' ') as String;
                  });
                }),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar')),
        TextButton(
            onPressed: () {
              if(nameClient != null ){
                //isNotEmpty TAMBEM
                //SERVICE.ADD OBJECT
              }
              Navigator.of(context).pop();
            },
            child: const Text('Adicionar')),
      ],
    );
  }
}
