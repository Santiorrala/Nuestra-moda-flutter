import 'package:flutter/material.dart';
import 'package:flutter_proyecto_2p/productos_pages/buscar_producto.dart';
import 'package:flutter_proyecto_2p/productos_pages/listar_producto.dart';
import 'package:flutter_proyecto_2p/productos_pages/registrar_productos_page.dart';

class ProductosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Productos'),
      ),
      body: Container(
        margin:const EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              
            Image.asset(
              'images/productoPage.png',
              width: 150,
              height: 150, // Subir la imagen 2.5 cm (150 px)
            ),
            const SizedBox(height: 20),
            const Text(
              'Productos',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _registrarProducto(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('Registrar Producto'),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _buscarProdcuto(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('Buscar Producto'),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _listarProducto(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child:const Text('Listar Producto'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _registrarProducto(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegistrarProductoPage()),
    );
  }

  void _buscarProdcuto(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BuscarProductosPage()),
    );
  }

  void _listarProducto(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ListarProductosPage()));
  }
}
