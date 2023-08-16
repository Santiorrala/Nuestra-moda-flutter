import 'package:flutter/material.dart';
import 'package:flutter_proyecto_2p/data_base/DatabaseHelper.dart';
import 'package:flutter_proyecto_2p/data_base/Facturas.dart';

class ListarFacturaPage extends StatelessWidget {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Facturas'),
      ),
      body: FutureBuilder<List<facturas>>(
        future: dbHelper.getFactura(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('No hay facturas registradas.');
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final producto = snapshot.data![index];
                return ListTile(
                  title: Text('ID: ${producto.id} - Nombre: ${producto.nombre}'),
                  subtitle: Text('Cantidad: ${producto.cantidad} - Tipo: ${producto.nombre} - Precio: ${producto.total}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
