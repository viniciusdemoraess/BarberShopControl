import 'package:barber_shop_control/dtos/func/func.dart';
import 'package:barber_shop_control/services/func_service.dart';
import 'package:flutter/material.dart';

class FuncAddScreen extends StatefulWidget {
  const FuncAddScreen({Key? key}) : super(key: key);

  @override
  State<FuncAddScreen> createState() => _FuncAddScreenState();
}

class _FuncAddScreenState extends State<FuncAddScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cpfController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Funcionário')),
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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Adicionar Funcionário',
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
                            
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    controller: cpfController,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Campo Obrigatório!';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      labelText: 'CPF',
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    controller: nameController,
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Campo Obrigatório!';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      labelText: 'Nome',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    controller: phoneController,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Campo Obrigatório!';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      labelText: 'Telefone',
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    controller: ageController,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Campo Obrigatório!';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      labelText: 'Idade',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                                  textInputAction: TextInputAction.next,
                                  controller: addressController,
                                  keyboardType: TextInputType.multiline,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor, entre com o Endereço';
                                    }
                                    return null;
                                  },
                                  minLines: 1,
                                  maxLines: 5,
                                  decoration: const InputDecoration(
                                    labelText: 'Endereço',
                                  ),
                                ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.done,
                              controller: salaryController,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, entre com o Salário';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: 'Salário',
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
                                    FuncService service = FuncService();
                                    Func client = Func(
                                        age: int.parse(ageController.text),
                                        name: nameController.text,
                                        address: addressController.text,
                                        salary: salaryController.text);

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
