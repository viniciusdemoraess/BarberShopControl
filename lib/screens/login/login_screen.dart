import 'package:barber_shop_control/dtos/user/user_local.dart';
import 'package:barber_shop_control/screens/home_screen/home_screen.dart';
import 'package:barber_shop_control/screens/login/signup_screen.dart';
import 'package:barber_shop_control/services/user_service.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  UserLocal userLocal = UserLocal();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   toolbarHeight: 150,
      //   backgroundColor: const Color.fromARGB(255, 1, 40, 71),
      //   title:const Align(
      //     alignment: Alignment.center ,
      //     child: Text(
      //       'BarberShop',
      //       style: TextStyle(
      //         color: Color.fromARGB(237, 207, 203, 133),
      //         fontSize: 28,
      //         fontWeight: FontWeight.bold,
      //       ),
      //     ),
      //   ),
      //   shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.only(
      //       bottomLeft: Radius.circular(300),

      //       // bottom: Radius.circular(150),
      //     ),
      //   ),
      //   automaticallyImplyLeading: false,
      // ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/barber.jpg'), fit: BoxFit.cover),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(top: 34.0),
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(80),
              //     child: const Image(
              //       width: 280,
              //       height: 280,
              //       image: AssetImage('assets/images/barber_logo.png'),
              //     ),
              //   ),
              // ),

              Padding(
                padding: const EdgeInsets.only(
                    left: 40, right: 40, top: 30, bottom: 30),
                child: Card(
                  color: const Color.fromARGB(207, 244, 235, 235),
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            children: [
                              TextFormField(
                                textInputAction: TextInputAction.next,
                                onSaved: (value) => userLocal.email = value,
                                initialValue: userLocal.email,
                                keyboardType: TextInputType.emailAddress ,
                                decoration: const InputDecoration(
                                  hintText: 'Email...',
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(
                                        top: 0), // add padding to adjust icon
                                    child: Icon(Icons.email),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Por Favor,  insira o email';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 30),
                              TextFormField(
                                textInputAction: TextInputAction.done,
                                onSaved: (value) => userLocal.password = value,
                                initialValue: userLocal.password,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  hintText: 'Senha...',
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(
                                        top: 0), // add padding to adjust icon
                                    child: Icon(Icons.lock),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Por Favor,  insira a senha';
                                  }
                                  return null;
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  UserService _userService = UserService();
                                  _userService.signIn(
                                    userLocal,
                                    onSuccess: () {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomeScreen()));
                                    },
                                    onFail: (e) {
                                      Text('$e');
                                    },
                                  );
                                }
                              },
                              child: const Text('Entrar'),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SignUpScreen(),
                                ));
                              },
                              child: const Text('Registrar-se'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
