import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'history_screen.dart';
import 'profile_screen.dart';
import 'user_model.dart';

class MainScreen extends StatefulWidget {
    const MainScreen({super.key});
    @override
    State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>{
  int _selectedIndex = 0;

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context){
    // Data user dikirim dari halaman login melalui arguments
    final UserModel user = ModalRoute.of(context)!.settings.arguments as UserModel;

    final List<Widget> pages = [
      DashboardScreen(user: user),
      HistoryScreen(user: user),
      ProfileScreen(user: user),
    ];

    return Scaffold(
      body:pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.amber,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label:"Beranda"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Riwayat"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }


}

