import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

//1. Widget Utama
class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Expense Tracker",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DashboardScreen(),
    );
  }
}

//2. Halaman Utama (Scaffold) - DIPERBARUI
class DashboardScreen extends StatelessWidget{
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Praktikum 2: Layouting"),
        backgroundColor: Colors.blue,
      ),
      //Menggunakan SingleChildScrollView agar layar bisa di-scroll
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              GreetingWidget(),
              SizedBox(height: 20),
              BalancedCardWidget(),
              SizedBox(height: 20),
              ActionButtonsWidget(),
              SizedBox(height: 20),
              RecentTransactionWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

//3. Stateless Widget (Sapaan - Dari modul 1)
class GreetingWidget extends StatelessWidget{
  const GreetingWidget({super.key});

  @override
  Widget build(BuildContext context){
    return const Row(
      children: [
        CircleAvatar(
          radius: 24, 
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.person, size:30, color:Colors.white),
        ),
        SizedBox(width:12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Text("Halo Budi", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("Selamat Datang Kembali!", style:TextStyle(fontSize: 14, color: Colors.grey)),
          ],
        ),
      ],
    );
  }
}

//4. Stateful Widget (Kartu Saldo - Dari Modul 1)
class BalancedCardWidget extends StatefulWidget{
  const BalancedCardWidget({super.key});

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
      color: Colors.blueAccent,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                const Text("Saldo Utama", style: TextStyle(fontSize: 16, color: Colors.white70)),
                IconButton(
                  icon: Icon(_isBalanceVisible ? Icons.visibility : Icons.visibility_off, color: Colors.white),
                  onPressed: _toggleVisibility,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              _isBalanceVisible ? 'Rp 5.000.000' : 'Rp *********',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white), 
            ),
          ],
        ),
      ),
    );
  }
}


//5. Widget Tombol Aksi
class ActionButtonsWidget extends StatelessWidget {
  const ActionButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton(Icons.arrow_downward, 'Pemasukan', Colors.green),
        _buildActionButton(Icons.arrow_upward, 'Pengeluaran', Colors.red),
        _buildActionButton(Icons.swap_horiz, 'Transfer', Colors.blue),

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
                  '- Rp 50.000',
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
                  '+Rp 5.000.000',
                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(height:1),

              //Item Transaksi 3
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.directions_car, color: Colors.white),
                ),
                title: const Text("Isi Bensin"),
                subtitle: const Text('10 Sep 2026'),
                trailing: const Text(
                  '- Rp 150.000',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold), //TUGAS1
                ),
              ),


              //TUGAS 2
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.yellow,
                  child: Icon(Icons.electric_bolt, color: Colors.red),
                ),
                title: const Text("Bayar Token Listrik"),
                subtitle: const Text('10 Sep 2026'),
                trailing: const Text(
                  '- Rp 50.000',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.phone_android, color: Colors.white),
                ),
                title: const Text("Bayar Subscription Aplikasi"),
                subtitle: const Text('10 Sep 2026'),
                trailing: const Text(
                  '- Rp 384.000',
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