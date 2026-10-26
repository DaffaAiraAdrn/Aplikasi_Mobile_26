class TransactionModel {
  final int? id;
  final int userId;
  final String title;
  final int amount;
  final String category;
  final String date;

  TransactionModel({
    this.id,
    required this.userId,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
  });

  // Transaksi dengan kategori Pemasukan menambah saldo, selain itu mengurangi
  bool get isIncome => category == 'Pemasukan';

  // Mengubah TransactionModel menjadi Map. Key harus sama dengan nama kolom pada tabel transaksi.
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'idPengguna': userId,
      'judul': title,
      'nominal': amount,
      'kategori': category,
      'tanggal': date,
    };
  }
}
