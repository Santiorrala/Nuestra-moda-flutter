import 'package:flutter_proyecto_2p/data_base/Facturas.dart';
import 'package:flutter_proyecto_2p/data_base/Productos.dart';
import 'package:flutter_proyecto_2p/data_base/Usuarios.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _databasenombre = "Nuestra_moda.db";
  static final _databaseversion = 1;

  DatabaseHelper._privateconstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateconstructor();
  Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    String dbPaht = join(await getDatabasesPath(), _databasenombre);
    return await openDatabase(
      dbPaht,
      version: _databaseversion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE productos(id INTEGER PRIMARY KEY AUTOINCREMENT, nombre TEXT, cantidad INT, tipo TEXT, precio FLOAT)',
    );
    await db.execute(
      'CREATE TABLE factura(id INTEGER PRIMARY KEY AUTOINCREMENT, nombre TEXT, apellido TEXT, email TEXT, cantidad INT, total FLOAT)',
    );
    await db.execute(
      'CREATE TABLE usuario(id INTEGER PRIMARY KEY AUTOINCREMENT, usuario TEXT, password TEXT, email TEXT)',
    );
  }

  Future<int> insertarProductos(productos objeto) async {
    final db = await database;
    return await db!.insert('productos', objeto.toMap());
  }

  Future<int> insertFactura(facturas objeto) async {
    final db = await database;
    return await db!.insert('factura', objeto.toMap());
  }

  Future<int> insertUsuario(Usuarios usuarios) async {
    final db = await database;
    return await db!.insert('usuario', usuarios.toMap());
  }

  Future<List<productos>> getProductos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query('productos');
    return List.generate(maps.length, (i) {
      return productos.fromMap(maps[i]);
    });
  }

  Future<productos> getProductoPorId(int id) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db!.query(
      'productos',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return productos.fromMap(maps.first);
    } else {
      return productos(
        id: -1,
        nombre: '',
        cantidad: 0,
        tipo: '',
        precio: 0,
      );
    }
  }

  Future<int> actualizarProducto(productos producto) async {
    final db = await database;
    return await db!.update(
      'productos',
      producto.toMap(),
      where: 'id =?',
      whereArgs: [producto.id],
    );
  }

  Future<void> eliminarProducto(int id) async {
    final db = await database;
    await db!.delete(
      'productos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> restarCantidadProducto(int productoId, int cantidad) async {
    final db = await database;
    await db!.rawUpdate(
      'UPDATE productos SET cantidad = cantidad - ? WHERE id = ?',
      [cantidad, productoId],
    );
  }

  Future<List<facturas>> getFactura() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query('factura');
    return List.generate(maps.length, (i) {
      return facturas.fromMap(maps[i]);
    });
  }

  Future<bool> checkLogin(String usuario, String password) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db!.query(
      'usuario',
      where: 'usuario = ? AND password = ?',
      whereArgs: [usuario, password],
    );
    return result.isNotEmpty;
  }
  updateProductoCantidad({int? id, required int cantidad}) {}

  updateCantidadProducto(int productoId, int cantidad) {}

  updateProducto(productos producto) {}
}