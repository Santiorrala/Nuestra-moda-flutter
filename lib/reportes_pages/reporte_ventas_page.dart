import 'package:flutter/material.dart';
import 'package:flutter_proyecto_2p/data_base/DatabaseHelper.dart';
import '../data_base/Facturas.dart'; 

class ReporteVentasPage extends StatefulWidget {
  @override
  _ReporteVentasPageState createState() => _ReporteVentasPageState();
}

class _ReporteVentasPageState extends State<ReporteVentasPage> {
  List<facturas> _facturasList = []; // Lista para almacenar las facturas
  double _totalVendido = 0.0; // Variable para almacenar la sumatoria de los totales

  @override
  void initState() {
    super.initState();
    _cargarFacturas();
  }

  void _cargarFacturas() async {
    DatabaseHelper dbHelper = DatabaseHelper.instance;
    List<facturas> facturasList = await dbHelper.getFactura();

    double totalVendido = 0.0;
    for (var factura in facturasList) {
      totalVendido += factura.total;
    }

    setState(() {
      _facturasList = facturasList;
      _totalVendido = totalVendido;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Reporte de Ventas'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Text(
                'Total vendido: \$$_totalVendido',
                style:const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Container(
                height: MediaQuery.of(context).size.height * 0.6, // Altura para el ScrollView
                child: ListView.builder(
                  itemCount: _facturasList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('ID: ${_facturasList[index].id}'),
                      subtitle: Text('Nombre: ${_facturasList[index].nombre}\nEmail: ${_facturasList[index].email}\nTotal: \$${_facturasList[index].total.toStringAsFixed(2)}'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
