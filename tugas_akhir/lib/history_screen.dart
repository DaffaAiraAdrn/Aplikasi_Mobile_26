import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'database.dart';
import 'transaction_model.dart';
import 'user_model.dart';

class HistoryScreen extends StatefulWidget{
  final UserModel user;

  const HistoryScreen({super.key, required this.user});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<TransactionModel> _transactions = [];

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  // Mengambil semua transaksi milik user dari database
  Future<void> _loadTransactions() async {
    final List<TransactionModel> data = await transactions(widget.user.id!);
    if (!mounted) return;
    setState(() {
      _transactions = data;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Transaksi"),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: TransactionListWidget(transactions: _transactions),
      ),
    );
  }
}
