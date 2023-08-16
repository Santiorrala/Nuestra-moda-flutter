import 'package:flutter/material.dart';
import 'package:flutter_proyecto_2p/facturas_pages/registrar_facturas_page.dart';
import 'package:flutter_proyecto_2p/facturas_pages/listar_factura.dart';

class FacturasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Facturas'),
      ),
      body: Container(
        margin:const EdgeInsets.all(20), // Márgenes alrededor del contenido
        alignment: Alignment.center, // Alinea el contenido al centro
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Alinea la columna arriba
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 25.4 * 2.5), // Espacio para subir la imagen 2.5 cm (1 cm = 25.4 unidades)
            Image.asset(
              'images/facturacion.png',
              width: 250,
              height: 200,
            ),
            const SizedBox(height: 20),
            const Text(
              'Facturas',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: ElevatedButton(
                    onPressed: () {
                      _registrarFactura(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding:const EdgeInsets.symmetric(vertical: 13), backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child:const Text(
                      'Registrar Factura',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: ElevatedButton(
                    onPressed: () {
                      _listarFactura(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding:const EdgeInsets.symmetric(vertical: 13),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child:const Text(
                      'Listar Factura',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  void _registrarFactura(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegistrarFacturaPage()),
    );
  }
  void _listarFactura(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ListarFacturaPage()));
  }
}
