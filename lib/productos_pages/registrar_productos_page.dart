import 'package:flutter/material.dart';
import 'package:flutter_proyecto_2p/data_base/DatabaseHelper.dart';
import 'package:flutter_proyecto_2p/data_base/Productos.dart';

// ignore: must_be_immutable
class RegistrarProductoPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _cantidadController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  String _selectedTipo = 'Zapato'; // Valor por defecto
  DatabaseHelper dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Producto'),
      ),
      body: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Image.asset(
              'images/registrarProducto.png',
              width: 150,
            ),
            const SizedBox(height: 20),
            const Text(
              'Registrar Producto',
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
                    }
                    
                 ),
                 TextFormField(
                    controller: _cantidadController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Cantidad'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'La cantidad es requerida';
                      }
                      int cantidad = int.tryParse(value) ?? 0;
                      if(cantidad <=0) {
                        return 'La cantidad debe ser un número positivo';
                      }
                      return null;
                    }
                  ),
                  DropdownButton<String>(
                    value: _selectedTipo,
                    onChanged: (newValue) {
                      // Acción cuando se selecciona un tipo
                      _selectedTipo = newValue!;
                    },
                    items: ['Zapato', 'Pantalon', 'Camiseta', 'Accesorio']
                        .map<DropdownMenuItem<String>>(
                          (String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ),
                        )
                        .toList(),
                  ),
                  TextFormField(
                    controller: _precioController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Precio'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'La cantidad es requerida';
                      }
                      int cantidad = int.tryParse(value) ?? 0;
                      if(cantidad <=0) {
                        return 'La cantidad debe ser un número positivo';
                      }
                      return null;
                    }
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
               if(_formKey.currentState!.validate()){
                _registrarProducto(context);
               }
              },
              child: const Text('Registrar Producto'),
            ),
          ],
        ),
      ),
      ),
    );
  }
  void _registrarProducto(context) async{
    String nombre = _nombreController.text;
    int cantidad = int.parse(_cantidadController.text);
    String tipo = _selectedTipo;
    double precio = double.parse(_precioController.text);

                
    productos newProdcuto  = productos(
    nombre: nombre,
    cantidad : cantidad,
    tipo : tipo,
    precio : precio,
    );
                
    await dbHelper.insertarProductos(newProdcuto);
    ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
    content: Text('Producto Registrado'),
    )
   );

  }
}
