import 'package:flutter/material.dart';
import 'package:flutter_proyecto_2p/data_base/DatabaseHelper.dart';
import 'package:flutter_proyecto_2p/data_base/Productos.dart';

class ListarProductosPage extends StatelessWidget {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Productos'),
      ),
      body: FutureBuilder<List<productos>>(
        future: dbHelper.getProductos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No hay productos registrados.');
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final producto = snapshot.data![index];
                return ListTile(
                  title: Text('ID: ${producto.id} - Nombre: ${producto.nombre}'),
                  subtitle: Text('Cantidad: ${producto.cantidad} - Tipo: ${producto.tipo} - Precio: ${producto.precio}'),
                  onTap: () {
                    Navigator.pop(context, producto);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
