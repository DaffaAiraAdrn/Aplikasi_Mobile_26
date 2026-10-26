import 'package:flutter/material.dart';
import 'database.dart';
import 'transaction_detail_screen.dart';
import 'transaction_model.dart';
import 'user_model.dart';

// Mengubah angka menjadi format rupiah, contoh: 5000000 menjadi 5.000.000
String formatRupiah(int value) {
  return value.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.');
}

class DashboardScreen extends StatefulWidget{
  final UserModel user;

  const DashboardScreen({super.key, required this.user});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<TransactionModel> _transactions = [];

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  // Mengambil transaksi milik user dari database
  Future<void> _loadTransactions() async {
    final List<TransactionModel> data = await transactions(widget.user.id!);
    if (!mounted) return;
    setState(() {
      _transactions = data;
    });
  }

  // Saldo = total pemasukan - total pengeluaran
  int _hitungSaldo() {
    int saldo = 0;
    for (final transaction in _transactions) {
      if (transaction.isIncome) {
        saldo += transaction.amount;
      } else {
        saldo -= transaction.amount;
      }
    }
    return saldo;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        title:const Text("Dashboard Keuangan"),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
        child: const Icon(Icons.add),
        onPressed: () async {
          // Kirim id user ke form, lalu muat ulang data setelah form ditutup
          await Navigator.pushNamed(context, "/add", arguments: widget.user.id);
          _loadTransactions();
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GreetingWidget(name: widget.user.name),
            const SizedBox(height: 20),
            BalancedCardWidget(balance: _hitungSaldo()),
            const SizedBox(height: 20),
            const ActionButtonsWidget(),
            const SizedBox(height: 20),
            const Text('Transaksi Akhir', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TransactionListWidget(transactions: _transactions.take(3).toList()),
          ],
          ),
      ),
    );

  }
}

//Stateless Widget (Sapaan - Dari modul 1)
class GreetingWidget extends StatelessWidget{
  final String name;

  const GreetingWidget({super.key, required this.name});

  @override
  Widget build(BuildContext context){
    return Row(
      children: [
        const CircleAvatar(
          radius: 24,
          backgroundColor: Colors.amber,
          child: Icon(Icons.person, size:30, color:Colors.white),
        ),
        const SizedBox(width:12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Text("Halo $name", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text("Selamat Datang Kembali!", style:TextStyle(fontSize: 14, color: Colors.grey)),
          ],
        ),
      ],
    );
  }
}

//Stateful Widget (Kartu Saldo - Dari Modul 1)
class BalancedCardWidget extends StatefulWidget{
  final int balance;

  const BalancedCardWidget({super.key, required this.balance});

  @override
  State<BalancedCardWidget> createState() => _BalancedCardWidgetState();
}

class _BalancedCardWidgetState extends State<BalancedCardWidget> {
  bool _isBalanceVisible = true;

  void _toggleVisibility() {
    setState(() {
      _isBalanceVisible = !_isBalanceVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.amber[400],
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                const Text("Saldo Utama", style: TextStyle(fontSize: 16, color: Colors.black54)),
                IconButton(
                  icon: Icon(_isBalanceVisible ? Icons.visibility : Icons.visibility_off, color: Colors.black),
                  onPressed: _toggleVisibility,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              _isBalanceVisible ? 'Rp ${formatRupiah(widget.balance)}' : 'Rp *********',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}


//Widget Tombol Aksi (Dari Modul 2)
class ActionButtonsWidget extends StatelessWidget {
  const ActionButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton(Icons.arrow_downward, 'Pemasukan', Colors.green),
        _buildActionButton(Icons.arrow_upward, 'Pengeluaran', Colors.red),
        _buildActionButton(Icons.swap_horiz, 'Transfer', Colors.amber),

      ],
    );
  }
  Widget _buildActionButton(IconData icon, String label, Color color) {
    return Column(
      children:[
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child:Icon(icon, color:color, size:28),
        ),
        const SizedBox(height:8),
        Text(
          label,
          style:const TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

//Daftar Transaksi (dari RecentTransactionWidget Modul 2), dipakai di Dashboard dan Riwayat
class TransactionListWidget extends StatelessWidget{
  final List<TransactionModel> transactions;

  const TransactionListWidget({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return const Text("Belum ada transaksi", style: TextStyle(color: Colors.grey));
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: transactions.map((TransactionModel transaction) {
          final String amount = '${transaction.isIncome ? '+' : '-'} Rp ${formatRupiah(transaction.amount)}';

          return ListTile(
            leading: CircleAvatar(
              backgroundColor: transaction.isIncome ? Colors.green : Colors.redAccent,
              child: Icon(transaction.isIncome ? Icons.arrow_downward : Icons.arrow_upward, color: Colors.white),
            ),
            title: Text(transaction.title),
            subtitle: Text(transaction.date),
            trailing: Text(
              amount,
              style: TextStyle(color: transaction.isIncome ? Colors.green : Colors.red, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TransactionDetailScreen(
                    title: transaction.title,
                    amount: amount,
                    category: transaction.category,
                    date: transaction.date,
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
