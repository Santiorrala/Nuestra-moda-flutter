class productos {
  final int? id;
  final String nombre;
  late final int cantidad;
  String tipo;
  double precio;

  productos({
    this.id,
    required this.nombre,
    required this.cantidad,
    required this.tipo,
    required this.precio,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'cantidad': cantidad,
      'tipo': tipo,
      'precio': precio
    };
  }

  factory productos.fromMap(Map<String, dynamic> map) {
    return productos(
      id: map['id'],
      nombre: map['nombre'],
      cantidad: map['cantidad'],
      tipo: map['tipo'],
      precio: map['precio'],
    );
  }
}
