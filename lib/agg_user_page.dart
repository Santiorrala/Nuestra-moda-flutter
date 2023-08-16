import 'package:flutter/material.dart';
import 'package:flutter_proyecto_2p/data_base/DatabaseHelper.dart';
import 'package:flutter_proyecto_2p/data_base/Usuarios.dart';

class AddUserPage extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Agregar Usuario'),
    ),
    body: SingleChildScrollView(
      child: Form(
      key: _formKey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Image.asset(
              'images/agg.png',
              width: 150,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(labelText: 'Usuario'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'El usuario es requerido';
                      }
                      return null;
                    }
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Contraseña'),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'La contraseña es requerido';
                      }
                      return null;
                    }
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Correo Electrónico'),
                    validator: (value){
                      if (value!.isEmpty) {
                        return 'El correo electrónico es requerido';
                      }
                      final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                      if (!emailRegExp.hasMatch(value)) {
                       return 'Ingresa un correo electrónico válido';
                        }
                      return null;
                    } ,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                   if(_formKey.currentState!.validate()){
                    _agregrauser(context);
                    }
                  },
                  child: const Text('Agregar'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    _regresar(context);
                  },
                  child: const Text('Cancelar'),
                ),
              ],
            ),
          ],
        ),
      ),
      ),
    ),
  );
}

  
  void _agregrauser(context) async{
    String usuario = _usernameController.text;
    String password = _passwordController.text;
    String email = _emailController.text;
    Usuarios newUser = Usuarios(
      usuario: usuario,
      password: password,
      email: email,
    );

    DatabaseHelper dbHelper = DatabaseHelper.instance;
    await dbHelper.insertUsuario(newUser);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content:  Text('Usuario agregado con exito.')
      )
    );
    _usernameController.clear();
    _passwordController.clear();
    _emailController.clear();
  }
  void _regresar(context){
    Navigator.pop(context);
  }
}

