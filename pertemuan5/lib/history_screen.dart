import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget{
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Transaksi"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: RecentTransactionWidget(),
      ),
    );
  }
}

//Daftar transaksi dari Praktikum 2
class RecentTransactionWidget extends StatelessWidget{
  const RecentTransactionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Transaksi Terakhir",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              //Item Transaksi 1
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  child: Icon(Icons.fastfood, color: Colors.white),
                ),
                title: const Text("Makan Siang"),
                subtitle: const Text('13 Sep 2026'),
                trailing: const Text(
                  '- Rp 25.000',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(height: 1),

              //Item Transaksi 2
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(Icons.attach_money, color: Colors.white),
                ),
                title: const Text('Gaji Bulanan'),
                subtitle: const Text('01 Sep 2026'),
                trailing: const Text(
                  '+Rp 2.500.000',
                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(height:1),

              //Item Transaksi 3
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.directions_bus, color: Colors.white),
                ),
                title: const Text("Naik Transpadang"),
                subtitle: const Text('10 Sep 2026'),
                trailing: const Text(
                  '- Rp 3.500',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold), //TUGAS1
                ),
              ),


              //TUGAS 2
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.cloud, color: Colors.white),
                ),
                title: const Text("Google One"),
                subtitle: const Text('10 Sep 2026'),
                trailing: const Text(
                  '- Rp 85.000',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.phone_android, color: Colors.white),
                ),
                title: const Text("Anthropic"),
                subtitle: const Text('10 Sep 2026'),
                trailing: const Text(
                  '- Rp 387.000',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}