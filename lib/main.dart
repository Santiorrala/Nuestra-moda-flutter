import 'package:flutter/material.dart';
import 'package:flutter_proyecto_2p/login_page.dart';
import 'package:flutter_proyecto_2p/data_base/DatabaseHelper.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.database;
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nuestra Moda',
      theme: ThemeData(primaryColor: Colors.lightGreen),
      home: LoginPage(),
    );
  }
}
