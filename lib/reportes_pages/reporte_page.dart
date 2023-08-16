import 'package:flutter/material.dart';
import 'package:flutter_proyecto_2p/reportes_pages/reporte_inventario_page.dart';
import 'package:flutter_proyecto_2p/reportes_pages/reporte_ventas_page.dart';

class ReportesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportes'),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 150, // Subir la imagen 2.5 cm (150 px)
              child: Image.asset(
                'images/reportePage.png',
                width: 150,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Reportes',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _reporteInventario(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Reporte de Inventario Disponible'),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _reporteVentas(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Reporte de Ventas Totales'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _reporteVentas(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReporteVentasPage()),
    );
  }

  void _reporteInventario(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReporteInventarioPage()),
    );
  }
}
