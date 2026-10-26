import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'transaction_model.dart';
import 'user_model.dart';

// Membuka database dan mengembalikan referensinya.
Future<Database> get database async {
  return openDatabase(
    join(await getDatabasesPath(), 'expense_tracker.db'),
    // Saat database pertama kali dibuat, dibuat tabel pengguna dan transaksi.
    onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE pengguna(id INTEGER PRIMARY KEY, nama TEXT, email TEXT UNIQUE, kataSandi TEXT)',
      ); //Field untuk kedua buah tabel, yakni tabel pengguna, dan tabel transaksi 
      await db.execute(
        'CREATE TABLE transaksi(id INTEGER PRIMARY KEY, idPengguna INTEGER, judul TEXT, nominal INTEGER, kategori TEXT, tanggal TEXT)',
      );
    },
    version: 1,
  );
}

// Menyimpan user baru ke tabel pengguna
Future<void> insertUser(UserModel user) async {
  // Ambil referensi database
  final db = await database;

  await db.insert('pengguna', user.toMap());
}

// Mencari user berdasarkan email, hasilnya null jika tidak ditemukan
Future<UserModel?> getUser(String email) async {
  final db = await database;

  // Gunakan whereArgs agar aman dari SQL injection
  final List<Map<String, Object?>> userMaps = await db.query(
    'pengguna',
    where: 'email = ?',
    whereArgs: [email],
  );

  // Ubah setiap baris data menjadi objek UserModel
  final List<UserModel> users = [
    for (final {'id': id as int, 'nama': name as String, 'email': userEmail as String, 'kataSandi': password as String}
        in userMaps)
      UserModel(id: id, name: name, email: userEmail, password: password),
  ];

  return users.isEmpty ? null : users.first;
}

// Menyimpan transaksi baru ke tabel transaksi
Future<void> insertTransaction(TransactionModel transaction) async {
  final db = await database;

  await db.insert('transaksi', transaction.toMap());
}

// Mengambil semua transaksi milik satu user, transaksi terbaru di atas
Future<List<TransactionModel>> transactions(int userId) async {
  final db = await database;

  final List<Map<String, Object?>> transactionMaps = await db.query(
    'transaksi',
    where: 'idPengguna = ?',
    whereArgs: [userId],
    orderBy: 'id DESC',
  );

  return [
    for (final {
          'id': id as int,
          'idPengguna': ownerId as int,
          'judul': title as String,
          'nominal': amount as int,
          'kategori': category as String,
          'tanggal': date as String,
        }
        in transactionMaps)
      TransactionModel(id: id, userId: ownerId, title: title, amount: amount, category: category, date: date),
  ];
}
