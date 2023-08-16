import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_proyecto_2p/agg_user_page.dart';
import 'package:flutter_proyecto_2p/principal_page.dart';
import 'package:flutter_proyecto_2p/data_base/DatabaseHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  DatabaseHelper dbHelper = DatabaseHelper.instance;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  _loadSavedCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _usernameController.text = prefs.getString('username') ?? '';
      _passwordController.text = prefs.getString('password') ?? '';
      _rememberMe = prefs.getBool('rememberMe') ?? false;
    });
  }

  _saveCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
      prefs.setString('username', _usernameController.text);
      prefs.setString('password', _passwordController.text);
      prefs.setBool('rememberMe', true);
    } else {
      prefs.remove('username');
      prefs.remove('password');
      prefs.remove('rememberMe');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sistema de Inventario'),
        backgroundColor: Color(0xFF76C1AE),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF76C1AE)),
              child: Text('Opciones de menu'),
            ),
            ListTile(
              title: const Text('Agregar usuario'),
              onTap: () => _agregarUsuario(context),
            ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                const Text(
                  'Sistema de Inventario',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Nuestra Moda',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'images/tienda.png',
                  width: 150,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'Usuario'),
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Contraseña'),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (value) {
                        setState(() {
                          _rememberMe = value!;
                        });
                      },
                    ),
                    const Text('Recordar usuario'),
                  ],
                ),
                Container(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      _validarCredenciales(context);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                     backgroundColor: Color(0xFF76C1AE),
                    ),
                    child: const Text('Ingresar'),
                    
                  ),
                ),
                Container(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      _finalizarApp();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    backgroundColor: Color(0xFF76C1AE),
                    ),
                    child: const Text('Salir'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _agregarUsuario(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddUserPage()),
    );
  }

  void _ingresarPaginaPrincipal(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainPage()),
    );
  }

  void _finalizarApp() {
    SystemNavigator.pop();
  }

  void _validarCredenciales(context) async {
    String usuario = _usernameController.text;
    String password = _passwordController.text;

    bool isLoggedIn = await dbHelper.checkLogin(usuario, password);
    if (isLoggedIn) {
      _ingresarPaginaPrincipal(context);
      _saveCredentials();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuario o contraseña incorrectos'),
        ),
      );
    }
  }
}
