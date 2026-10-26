class UserModel {
  final int? id;
  final String name;
  final String email;
  final String password;

  UserModel({this.id, required this.name, required this.email, required this.password});

  // Mengubah UserModel menjadi Map. Key harus sama dengan nama kolom pada tabel pengguna.
  Map<String, Object?> toMap() {
    return {'id': id, 'nama': name, 'email': email, 'kataSandi': password};
  }
}
