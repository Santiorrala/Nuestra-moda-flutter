import 'package:flutter/material.dart';
import 'package:flutter_proyecto_2p/data_base/DatabaseHelper.dart';
import 'package:flutter_proyecto_2p/data_base/Facturas.dart';
import 'package:flutter_proyecto_2p/data_base/Productos.dart';
import 'package:flutter_proyecto_2p/productos_pages/listar_producto.dart';

void main() {
  runApp(MaterialApp(
    home: RegistrarFacturaPage(),
  ));
}

class RegistrarFacturaPage extends StatefulWidget {
  @override
  _RegistrarFacturaPageState createState() => _RegistrarFacturaPageState();
}

class _RegistrarFacturaPageState extends State<RegistrarFacturaPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  productos? _productoSeleccionado;
  int _cantidad = 0;
  List<FacturaItem> _facturaItems = [];
  DatabaseHelper dbHelper = DatabaseHelper.instance;

  bool _canSelectProduct() {
    return _cantidad > 0 && _productoSeleccionado == null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Factura'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Image.asset(
                'images/facnew.png',
                width: 150,
              ),
              const SizedBox(height: 20),
              const Text(
                'Registrar Factura',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nombreController,
                      decoration: const InputDecoration(labelText: 'Nombre'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'El nombre es requerido';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _apellidoController,
                      decoration: const InputDecoration(labelText: 'Apellido'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'El apellido es requerido';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(labelText: 'Correo Electrónico'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'El correo electrónico es requerido';
                        }
                        // Puedes agregar validación adicional de formato de correo electrónico si es necesario
                        return null;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Cantidad'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'La cantidad es requerida';
                        }
                        int cantidad = int.tryParse(value) ?? 0;
                        if (cantidad <= 0) {
                          return 'La cantidad debe ser un número positivo';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _cantidad = int.tryParse(value) ?? 0;
                        });
                      },
                    ),
                    ElevatedButton(
                      onPressed: _canSelectProduct()
                          ? () async {
                              final producto = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ListarProductosPage(),
                                ),
                              );

                              if (producto != null) {
                                setState(() {
                                  _productoSeleccionado = producto;
                                  _facturaItems.add(FacturaItem(
                                    producto: producto,
                                    cantidad: _cantidad,
                                  ));
                                  _cantidad = 0;
                                });
                              }
                            }
                          : null,
                      child: const Text('Seleccionar Producto'),
                    ),
                    const Text('Productos seleccionados:'),
                    DataTable(
                      columns: [
                        DataColumn(
                          label: Container(width: 30, child: const Text('Cant')),
                        ),
                        const DataColumn(label: Text('Producto')),
                        const DataColumn(label: Text('Precio')),
                        const DataColumn(label: Text('')),
                      ],
                      rows: _facturaItems.asMap().entries.map((entry) {
                        final index = entry.key;
                        final item = entry.value;
                        return DataRow(
                          cells: [
                            DataCell(Text(item.cantidad.toString())),
                            DataCell(Text(item.producto.nombre)),
                            DataCell(Text(item.producto.precio.toString())),
                            DataCell(
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  setState(() {
                                    _facturaItems.removeAt(index);
                                  });
                                },
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                    Text('Total: ${_calcularTotal()}'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _facturaItems.isEmpty
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                _generarFactura(context);
                              }
                            },
                      child: const Text('Generar Factura'),
                    ),
                    ElevatedButton(
                      onPressed: _facturaItems.isNotEmpty
                          ? () {
                              setState(() {
                                _productoSeleccionado = null;
                                _cantidad = 0;
                              });
                            }
                          : null,
                      child: const Text('Agregar otro producto'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _calcularTotal() {
    double total = 0.0;
    for (var item in _facturaItems) {
      total += item.producto.precio * item.cantidad;
    }
    return total;
  }

  void _generarFactura(context) async {
    String nombre = _nombreController.text;
    String apellido = _apellidoController.text;
    String email = _emailController.text;
    double total = _calcularTotal();

    facturas newFactura = facturas(
      nombre: nombre,
      apellido: apellido,
      cantidad: _facturaItems.length,
      email: email,
      total: total,
    );

    await dbHelper.insertFactura(newFactura);

    for (var item in _facturaItems) {
      await dbHelper.restarCantidadProducto(item.producto.id!, item.cantidad);
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Factura Generada'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  'Factura generada correctamente, gracias por su compra $nombre $apellido'),
              const SizedBox(height: 10),
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 36,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _facturaItems.clear();
                  _productoSeleccionado = null;
                  _cantidad = 0;
                });
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}

class FacturaItem {
  final productos producto;
  final int cantidad;

  FacturaItem({required this.producto, required this.cantidad});
}
