import 'package:flutter/material.dart';
import 'package:websitepesan/halaman_detailproduk.dart';
import 'package:websitepesan/halaman_keranjang.dart';
import 'package:websitepesan/model/dummydata.dart';
import 'package:websitepesan/model/keranjang.dart';
import 'package:websitepesan/model/produk.dart';
import 'package:websitepesan/tombol/pengaturan.dart';
import 'package:websitepesan/tombol/profil.dart';

class HalamanBeranda extends StatefulWidget {
  final String email;
  const HalamanBeranda({super.key, required this.email});

  @override
  State<HalamanBeranda> createState() => _HalamanBerandaState();
}

class _HalamanBerandaState extends State<HalamanBeranda> {
  // Variabel untuk bottom navigation
  int _indexTerpilih = 0;
  
  // Keranjang belanja (state utama)
  final Keranjang _keranjang = Keranjang();
  List<Produk> produkList = DummyData.getProdukList();

  // Daftar halaman untuk bottom navigation
  late List<Widget> _halamanList;
  
  // Daftar judul untuk AppBar dinamis
  final List<String> _judulAppBar = [
    'Menu Gacoan',
    'Keranjang Belanja',
    'Profil Pengguna',
    'Pengaturan'
  ];

  @override
  void initState() {
    super.initState();
    // Inisialisasi halaman-halaman
    _halamanList = [
      _buildKontenBeranda(),
      HalamanKeranjang(keranjang: _keranjang, email : widget.email),
      HalamanProfil(email: widget.email),
      HalamanPengaturan(email: widget.email),
    ];
  }

  // FUNGSI YANG DIPINDAHKAN DARI KELAS KERANJANG
  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _kosongkanKeranjang() {
    setState(() {
      _keranjang.kosongkan();
    });
    _showSnackBar('Keranjang berhasil dikosongkan!', Colors.orange);
  }

  void _updateKeranjang() {
    setState(() {
      // Cukup refresh UI
    });
  }
  // AKHIR FUNGSI PINDAHAN

  void _logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Keluar'),
          content: const Text('Apakah Anda yakin ingin keluar?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text('Keluar'),
            ),
          ],
        );
      },
    );
  }

  // Widget untuk konten beranda asli
  Widget _buildKontenBeranda() {
    return Column(
      children: [
        // Banner promo
        Container(
          padding: const EdgeInsets.all(10),
          color: Colors.orange.shade100,
          child: const Row(
            children: [
              Icon(Icons.local_offer, color: Colors.orange),
              SizedBox(width: 8),
              Text(
                'Gratis ongkir untuk pesanan di atas Rp 50.000',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        // Daftar produk
        Expanded(
          child: ListView.builder(
            itemCount: produkList.length,
            itemBuilder: (context, index) {
              final produk = produkList[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      produk.gambar,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey,
                          child: const Icon(Icons.error),
                        );
                      },
                    ),
                  ),
                  title: Text(
                    produk.nama,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        produk.deskripsi,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.orange.shade500,
                            size: 16,
                          ),
                          Text(
                            produk.rating.toString(),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'Rp${produk.harga.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.add_shopping_cart),
                    onPressed: () {
                      setState(() {
                        _keranjang.tambahItem(produk);
                        _showSnackBar('${produk.nama} ditambahkan ke keranjang!', Colors.green);
                      });
                    },
                  ),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HalamanDetail(
                          produk: produk,
                          onTambahKeKeranjang: () {
                            setState(() {
                              _keranjang.tambahItem(produk);
                            });
                          },
                        ),
                      ),
                    );
                    setState(() {}); // Refresh state setelah kembali dari detail
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Fungsi untuk membangun actions AppBar secara dinamis
  List<Widget> _buildAppBarActions() {
    switch (_indexTerpilih) {
      case 0: // Halaman Beranda
        return [
          GestureDetector(
            onTap: () {
              setState(() {
                _indexTerpilih = 1; // Pindah ke tab keranjang
              });
            },
            child: Row(
              children: [
                Stack(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: () {
                         setState(() {
                           _indexTerpilih = 1; // Pindah ke tab keranjang
                         });
                      },
                      tooltip: 'Keranjang Belanja',
                    ),
                    if (_keranjang.totalItem > 0)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                          child: Text(
                            _keranjang.totalItem.toString(),
                            style: const TextStyle(color: Colors.white, fontSize: 8),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 2),
                Text(
                  'Rp${_keranjang.totalHarga.toStringAsFixed(0)}',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
        ];
      case 1: // Halaman Keranjang
        return [
          if (_keranjang.items.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Kosongkan Keranjang'),
                      content: const Text('Yakin ingin mengosongkan seluruh keranjang?'),
                      actions: [
                        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Batal')), 
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            _kosongkanKeranjang();
                          },
                          child: const Text('Ya, Kosongkan'),
                        ),
                      ],
                    );
                  },
                );
              },
              tooltip: 'Kosongkan Keranjang',
            ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _updateKeranjang,
            tooltip: 'Refresh Keranjang',
          ),
        ];
      default: // Halaman lain (Profil, Pengaturan)
        return [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
            tooltip: 'Keluar',
          ),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _judulAppBar[_indexTerpilih], // Judul dinamis
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange,
        elevation: 0,
        actions: _buildAppBarActions(), // Actions dinamis
        automaticallyImplyLeading: false, // Menghilangkan tombol back otomatis
      ),

      // Bottom Navigation Bar (navigasi bawah)
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indexTerpilih,
        selectedItemColor: Colors.orange,
        unselectedItemColor: const Color(0xff757575),
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _indexTerpilih = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_rounded),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart_rounded),
            label: 'Keranjang',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            activeIcon: Icon(Icons.person_rounded),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings_rounded),
            label: 'Pengaturan',
          ),
        ],
      ),

      // Body yang menampilkan halaman sesuai pilihan
      body: _halamanList[_indexTerpilih],
    );
  }
}
