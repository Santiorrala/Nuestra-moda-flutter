import 'package:flutter/material.dart';
import 'package:flutter_proyecto_2p/facturas_pages/factura_page.dart';
import 'package:flutter_proyecto_2p/login_page.dart';
import 'package:flutter_proyecto_2p/productos_pages/producto_page.dart';
import 'package:flutter_proyecto_2p/reportes_pages/reporte_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NuestraModa'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/tienda.png',
              width: 150,
            ),
            const SizedBox(height: 20),
            const Text(
              'NuestraModa',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCard(
                  'images/producto.png',
                  'Productos',
                  ProductosPage(),
                  context,
                ),
                _buildCard(
                  'images/facnew.png',
                  'Facturas',
                  FacturasPage(),
                  context,
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCard(
                  'images/report.png',
                  'Reportes',
                  ReportesPage(),
                  context,
                ),
                _buildCardCerrarSesion(
                  'images/cerrarsesion.png',
                  'Cerrar Sesión',
                  () => _showLogoutConfirmationDialog(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String imagePath, String title, Widget pageToNavigate, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => pageToNavigate,
          ),
        );
      },
      child: Card(
        elevation: 5,
        child: SizedBox(
          width: 150, // Ajusta este valor para cambiar el ancho de las tarjetas
          child: Column(
            children: [
              Image.asset(
                imagePath,
                width: 100,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style:const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardCerrarSesion(String imagePath, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        child: Container(
          width: 150, // Ajusta este valor para cambiar el ancho de las tarjetas
          child: Column(
            children: [
              Image.asset(
                imagePath,
                width: 100,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style:const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleLogout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (Route<dynamic> route) => false,
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:const Text('Cerrar Sesión'),
          content: const Text('¿Estás seguro de que deseas cerrar sesión?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cierra el cuadro de diálogo
              },
              child:const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cierra el cuadro de diálogo
                _handleLogout(context);
              },
              child:const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}
