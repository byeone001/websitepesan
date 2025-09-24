
/*import 'package:flutter/material.dart';
import 'package:websitepesan/halaman_beranda.dart';
import 'package:websitepesan/halaman_keranjang.dart';
import 'package:websitepesan/model/keranjang.dart';
import 'package:websitepesan/tombol/pengaturan.dart';

class MainScreen extends StatefulWidget {
  final String email;
  const MainScreen({super.key, required this.email});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late Keranjang keranjang;

  @override
  void initState() {
    super.initState();
    keranjang = Keranjang(); // Inisialisasi keranjang sekali
  }

  // Daftar halaman yang akan ditampilkan
  List<Widget> get _pages => [
        HalamanBeranda(
          email: widget.email,
          keranjang: keranjang, // Kirim keranjang yang sama ke beranda
        ),
        HalamanKeranjang(
          keranjang: keranjang,
          email: widget.email,
        ),
        HalamanPengaturan(email: widget.email),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Keranjang',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
        backgroundColor: Colors.orange,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
      ),
    );
  }
}*/