class Usuarios{
  final int? id;
  final String usuario;
  final String password;
  final String email;

  Usuarios({this.id,
  required this.usuario,
  required this.password,
  required this.email});

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'usuario': usuario,
      'password': password,
      'email': email
    };
  }
  factory Usuarios.fromMap(Map<String, dynamic> map){
      return Usuarios(id: map['id'],
      usuario: map['usuario'],
      password: map['password'],
      email: map['email']);
    }
}