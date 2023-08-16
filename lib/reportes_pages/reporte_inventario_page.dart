import 'package:flutter/material.dart';
import 'package:flutter_proyecto_2p/data_base/DatabaseHelper.dart';
import '../data_base/Productos.dart';

class ReporteInventarioPage extends StatefulWidget {
  @override
  _ReporteInventarioPageState createState() => _ReporteInventarioPageState();
}

class _ReporteInventarioPageState extends State<ReporteInventarioPage> {
  List<productos> _productosList = [];

  @override
  void initState() {
    super.initState();
    _cargarProductos();
  }

  void _cargarProductos() async {
    DatabaseHelper dbHelper = DatabaseHelper.instance;
    List<productos> productosList = await dbHelper.getProductos();

    setState(() {
      _productosList = productosList;
    });
  }


  // Método para actualizar la lista de productos
  void actualizarProductos() {
    _cargarProductos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reporte de Inventario'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 5),
              Text(
                'Productos Disponibles: ${_productosList.fold(0, (total, producto) => total + producto.cantidad)}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: ListView.builder(
                  itemCount: _productosList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('ID: ${_productosList[index].id}'),
                      subtitle: Text('Nombre: ${_productosList[index].nombre}\nCantidad: ${_productosList[index].cantidad}'),
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