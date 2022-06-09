import 'package:barber_shop_control/dtos/client/client.dart';
import 'package:barber_shop_control/services/client_service.dart';
import 'package:flutter/material.dart';

class ClientAddScreen extends StatefulWidget {
  const ClientAddScreen({Key? key}) : super(key: key);

  @override
  State<ClientAddScreen> createState() => _ClientAddScreenState();
}

class _ClientAddScreenState extends State<ClientAddScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController phoneController = TextEditingController();



  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Cliente ')),
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
                      'Adicionar Cliente',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Expanded(child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  controller: cpfController,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor, entre com o CPF';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'CPF',
                                  ),
                                ),),
                                const SizedBox(width: 15,),
                                Expanded(child:TextFormField(
                              textInputAction: TextInputAction.next,
                              controller: nameController,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, entre com o nome';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: 'Nome',
                              ),
                            ), ),
                                
                              ],
                            ),
                            
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              controller: ageController,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, entre com o Idade';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: 'Idade',
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              controller: phoneController,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, entre com o Telefone';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: 'Telefone',
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.done,
                              controller: addressController,
                              keyboardType: TextInputType.multiline,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, entre com o Endereco';
                                }
                                return null;
                              },
                              minLines: 1,
                              maxLines: 5,
                              decoration: const InputDecoration(
                                labelText: 'Endereco',
                                
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    //acess services of persistence
                                    ClientService service = ClientService();
                                    Client client = Client(
                                        int.parse(ageController.text),
                                        nameController.text,
                                        addressController.text);

                                    service.add(client);
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: const Text("Salvar Dados"),
                              ),
                            ),
                          ],
                        ),
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
