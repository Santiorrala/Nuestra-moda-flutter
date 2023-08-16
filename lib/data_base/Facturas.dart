class facturas{
  final int? id;
  final String nombre;
  final String apellido;
  final String email;
  final int cantidad;
  final double total;

  facturas({
    this.id,
    required this.nombre,
    required this.apellido,
    required this.email,
    required this.cantidad,
    required this.total,
  });

   Map <String, dynamic> toMap(){
    return {
      'id': id,
      'nombre': nombre,
      'apellido': apellido,
      'email': email,
      'cantidad': cantidad,
      'total': total
    };
   }
   factory facturas.fromMap(Map<String, dynamic> map){
    return facturas(
      id: map['id'],
      nombre: map['nombre'],
      apellido: map['apellido'],
      email: map['email'],
      cantidad: map['cantidad'],
      total: map['total'],
    );
   }

}