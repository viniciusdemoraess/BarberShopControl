// import 'package:cloud_firestore/cloud_firestore.dart';
// import "package:firebase_auth/firebase_auth.dart";
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:barber_shop_control/dtos/user/user_local.dart';

// //FirebaseFirestore -> permite acesso as dados no FIREBASE
// //através da obtenção da instância deste.
// //inicialização da instância de autenticação no firebase
// // FirebaseAuth auth = FirebaseAuth.instance;

// class UserManager extends ChangeNotifier {
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;

//   UserLocal? userLocal;
//   //construtores
//   UserManager() {
//     //verifica a autenticação do usuário e carrega-o
//     _loadingCurrentUser();
//   }

//   String? _email;
//   String? _imageUrl;

//   bool _loading = false;
//   bool get loading => _loading;

//   // ignore: unnecessary_null_comparison
//   bool get isLoggedIn => userLocal != null; //para ser utilizado na Gaveta
//   set loading(bool value) {
//     _loading = value;
//     notifyListeners();
//   }

//   bool _loadingFacebook = false;
//   bool get loadingFacebook => _loadingFacebook;
//   set loadingFacebook(bool value) {
//     _loadingFacebook = value;
//     notifyListeners();
//   }

//   //recebendo uma função anônima (Function)
//   //as chaves determinam acesso como opção
//   Future<void> signIn(
//       {required UserLocal userLocal,
//       Function? onFail,
//       Function? onSucess}) async {
//     loading = true;
//     try {
//       final User? user = (await auth.signInWithEmailAndPassword(
//               email: userLocal.email!, password: userLocal.password!))
//           .user;
//       userLocal.id = user!.uid;
//       this.userLocal = userLocal;
//       // user = auth.currentUser;

//       //verifica se a sessã do usuário ainda é válida,
//       //assim não precisa realizar nova autenticação
//       await _loadingCurrentUser(user: user);
//       // this.user = result.user;
//       onSucess!();
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         debugPrint('Não há usuário com este email.');
//       } else if (e.code == 'wrong-password') {
//         debugPrint('Senha errada fornecida para este usuário.');
//       }
//     } on PlatformException catch (e) {
//       onFail!(e.code.toString());
//     }
//     //chama o set
//     loading = false;
//   }

//   Future<void> signUp(
//       {required UserLocal userLocal,
//       required Function onFail,
//       required Function onSucess}) async {
//     loading = true;
//     try {
//       final User? user = (await auth.createUserWithEmailAndPassword(
//               email: userLocal.email!, password: userLocal.password!))
//           .user;
//       userLocal.id = user!.uid;
//       this.userLocal = userLocal;
//       await userLocal.saveData();
//       //
//       onSucess();
//     } on PlatformException catch (e) {
//       onFail(e.code.toString());
//     }
//     loading = false;
//   }

//   void signOut() {
//     auth.signOut();
//     userLocal = null;
//     notifyListeners();
//   }

//   Future<void> _loadingCurrentUser({User? user}) async {
//     final User? currentUser = user ?? auth.currentUser;
//     if (currentUser != null) {
//       final DocumentSnapshot docUser =
//           await firestore.collection('users').doc(currentUser.uid).get();
//       userLocal = UserLocal.fromDocument(docUser);
//       final docAdmin =
//           await firestore.collection('admins').doc(userLocal!.id).get();
//       if (docAdmin.exists) {
//         userLocal!.admin = true;
//       }
//       notifyListeners();
//     }
//   }
 
//   if(userLocal.admin) {} 
//   bool get adminEnabled => userLocal != null && userLocal!. ;

// // void _signInUserWithEmailAndPassword() async {
// //   try {
// //     auth.User signedInUser =
// //         await Provider.of<AuthService>(context, listen: false)
// //             .signInUserWithEmailAndPassword(email: _email, password: _password);
// //     if (signedInUser != null) {
// //       print(
// //           'Signed in user: Email: ${signedInUser.email} Password: $_password}');
// //       Navigator.of(context).pushAndRemoveUntil(
// //           MaterialPageRoute(
// //               builder: (BuildContext context) => Home(
// //                     firebaseUser: signedInUser,
// //                   )),
// //           (Route<dynamic> route) => false);
// //     } else {
// //       print('Signed in user is null!');
// //     }
// //   } on auth.FirebaseAuthException catch (error) {
// //     print('AuthException: ' + error.message.toString());
// //     return _buildErrorDialog(context, error.message.toString());
// //   } on Exception catch (error) {
// //     print('Exception: ' + error.toString());
// //     return _buildErrorDialog(context, error.toString());
// //   }
// // }

//   Future<User?> createUserUsingEmailPassword({
//     required String name,
//     required String email,
//     required String password,
//   }) async {
//     User? user;
//     try {
//       UserCredential userCredential = await auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       user = userCredential.user;
//       await user!.updateDisplayName(name);
//       await user.reload();
//       user = auth.currentUser;
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         debugPrint('A senha fornecida é fraca demais!!!!');
//       } else if (e.code == 'email-already-in-use') {
//         debugPrint('Usuário já existe para este email.');
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//     return user;
//   }

//   Future<User?> signInUsingEmailPassword({
//     required String email,
//     required String password,
//     required BuildContext context,
//   }) async {
//     User? user;

//     try {
//       UserCredential userCredential = await auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       user = userCredential.user;
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         debugPrint('Usuário não encontrado para este email.');
//       } else if (e.code == 'wrong-password') {
//         debugPrint('A senha inserida está errada.');
//       }
//     }

//     return user;
//   }
// }