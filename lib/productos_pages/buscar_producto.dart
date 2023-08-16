import 'package:flutter/material.dart';
import 'package:flutter_proyecto_2p/data_base/DatabaseHelper.dart';
import 'package:flutter_proyecto_2p/data_base/Productos.dart';


class BuscarProductosPage extends StatefulWidget {
  @override
  _BuscarProductosPageState createState() => _BuscarProductosPageState();
}

class _BuscarProductosPageState extends State<BuscarProductosPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _cantidadController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  String _selectedTipo = 'Zapato'; // Valor por defecto

  String _mensaje = '';
  productos? _productoEncontrado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Productos'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Buscar Productos',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _idController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'ID del Producto'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _buscarProducto();
              },
              child: const Text('Buscar'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nombreController,
              decoration:const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _cantidadController,
              keyboardType: TextInputType.number,
              decoration:const InputDecoration(labelText: 'Cantidad'),
            ),
            DropdownButton<String>(
              value: _selectedTipo,
              onChanged: (newValue) {
                // Acción cuando se selecciona un tipo
                _selectedTipo = newValue!;
              },
              items: ['Zapato', 'Pantalón', 'Camiseta', 'Accesorio']
                  .map<DropdownMenuItem<String>>(
                    (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ),
                  )
                  .toList(),
            ),
            TextField(
              controller: _precioController,
              keyboardType: TextInputType.number,
              decoration:const InputDecoration(labelText: 'Precio'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                   _actualizarProducto();
                  },
                  child:const Text('Actualizar'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                   _eliminarProducto(context);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Eliminar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _buscarProducto()async{
    int? idProducto = int.tryParse(_idController.text);
    if(idProducto == null){
     setState(() {
        _mensaje = 'Ingresa un ID válido';
      });
      return;
    }
    DatabaseHelper dbHelper = DatabaseHelper.instance;
    _productoEncontrado = await dbHelper.getProductoPorId(idProducto);

    if(_productoEncontrado!.id != -1){
      setState(() {
        _mensaje = '';

        //actualizar los controladores de texto y el tipo

        _nombreController.text = _productoEncontrado!.nombre;
        _cantidadController.text = _productoEncontrado!.cantidad.toString();
        _selectedTipo = _productoEncontrado!.tipo;
        _precioController.text = _productoEncontrado!.precio.toString();
      });
      
    }else{
      setState(() {
        _productoEncontrado = null;
        _mensaje = 'No se encontró el producto';
        _nombreController.clear();
        _cantidadController.clear();
        _selectedTipo = 'Zapato';
        _precioController.clear();
      });
    }
    if(_mensaje.isNotEmpty){
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_mensaje),
        ),
      );
    }
  }
  void _actualizarProducto()async{
    if (_productoEncontrado == null){
      setState(() {
        _mensaje ='No hay producto para actualizar';
      });
      return;
    }

    String nombre = _nombreController.text;
    int? cantidad = int.tryParse(_cantidadController.text);
    String tipo = _selectedTipo;
    double? precio = double.tryParse(_precioController.text);

    productos productoActualizado = productos(id:_productoEncontrado!.id, nombre: nombre, cantidad: cantidad ?? 0, tipo: tipo, precio: precio ?? 0);

    DatabaseHelper dbHelper = DatabaseHelper.instance;
    await dbHelper.actualizarProducto(productoActualizado);

    setState(() {
      _mensaje = 'Producto actualizado con exito';
      _productoEncontrado = productoActualizado;
    });
    if(_mensaje.isNotEmpty){
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_mensaje),
        ),
      );
  
    }
  }
  void _eliminarProducto(BuildContext context) async {
  if (_productoEncontrado != null) {
    final confirmado = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:const Text('Confirmar eliminación'),
          content:const Text('¿Estás seguro de que deseas eliminar este producto?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Confirmado
              },
              child: const Text('Aceptar'),
              style: TextButton.styleFrom(
                primary: Colors.red,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Cancelado
              },
              child:const Text('Cancelar'),
            ),
          ],
        );
      },
    );

    if (confirmado == true) {
      DatabaseHelper dbHelper = DatabaseHelper.instance;
      await dbHelper.eliminarProducto(_productoEncontrado?.id ?? 0);
      setState(() {
        _mensaje = 'Producto eliminado';
        _nombreController.clear();
        _cantidadController.clear();
        _selectedTipo = 'Zapato';
        _precioController.clear();
        _productoEncontrado = null;
      });
    }
  } else {
    setState(() {
      _mensaje = 'No se puede eliminar, producto no encontrado';
    });
  }
  }


}
