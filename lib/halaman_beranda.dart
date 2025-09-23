import 'package:flutter/material.dart';
import 'package:websitepesan/halaman_detailproduk.dart';
import 'package:websitepesan/halaman_keranjang.dart';
import 'package:websitepesan/model/dummydata.dart';
import 'package:websitepesan/model/keranjang.dart';
import 'package:websitepesan/model/produk.dart';

class HalamanBeranda extends StatefulWidget {
  final String email;
  const HalamanBeranda({super.key, required this.email});

  @override
  State<HalamanBeranda> createState() => _HalamanBerandaState();
}

class _HalamanBerandaState extends State<HalamanBeranda> {
  // Pindahkan inisialisasi keranjang ke sini
  final Keranjang _keranjang = Keranjang();

  List<Produk> produkList = DummyData.getProdukList(); // Ambil produk dari data dummy
  
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
                Navigator.pushReplacementNamed(context, '/');
              },
              child: const Text('Keluar'),
            ),
          ],
        );
      },
    );
  }

  void _bukaHalamanKeranjang() async {
    // Gunakan await untuk menunggu hasil dari halaman keranjang
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HalamanKeranjang(keranjang: _keranjang),
      ),
    );
    
    // Jika kembali dari halaman keranjang, refresh UI
    if (result == true) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MENU GACOAN',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange,
        elevation: 0,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: _bukaHalamanKeranjang,
                tooltip: 'Keranjang Belanja',
              ),
              if (_keranjang.totalItem > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      _keranjang.totalItem.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
            tooltip: 'Keluar',
          ),
        ],
      ),
      body: Column(
        children: [
          // Info pengguna dan ringkasan keranjang
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.orange.shade50,
            child: Row(
              children: [
                const Icon(Icons.person, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.email,
                    style: const TextStyle(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: _bukaHalamanKeranjang,
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          const Icon(Icons.shopping_cart, size: 24),
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
                                constraints: const BoxConstraints(
                                  minWidth: 14,
                                  minHeight: 14,
                                ),
                                child: Text(
                                  _keranjang.totalItem.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Rp${_keranjang.totalHarga.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Banner promo
          Container(
            padding: const EdgeInsets.all(16),
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
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${produk.nama} ditambahkan ke keranjang!'),
                              backgroundColor: Colors.green,
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        });
                      },
                    ),
                    onTap: () async {
                      final result = await Navigator.push(
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
                      
                      if (result == true) {
                        setState(() {});
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/*import 'package:cobacoba/detail_produk.dart';
import 'package:cobacoba/model/makanan.dart';
import 'package:cobacoba/model/produk.dart';
import 'package:flutter/material.dart';

class Beranda extends StatelessWidget {
  Beranda({super.key});

  // Dummy data pakai polymorphism
  final List<Produk> produkList = [
    Makanan(
      nama: "Nasi Goreng Spesial",
      harga: 25000,
      gambar: "assets/nasi_goreng.jpg",
    ),
    Makanan(
      nama: "Sate Ayam",
      harga: 20000,
      gambar: "assets/sate_ayam.jpg",
    ),
    Minuman(
      nama: "Es Teh Manis",
      harga: 5000,
      gambar: "assets/es_teh.jpg",
    ),
    Minuman(
      nama: "Jus Alpukat",
      harga: 15000,
      gambar: "assets/jus_alpukat.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final email = args?["email"] ?? "User";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Beranda"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/login");
            },
          )
        ],
      ),
      backgroundColor: Colors.blue[50],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero Section
          Stack(
            children: [
              Image.asset(
                'assets/buri.jpeg',
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
              Positioned(
                left: 16,
                bottom: 16,
                child: Text(
                  "Selamat datang, $email!",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 4,
                        color: Colors.black,
                        offset: Offset(2, 2),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),

          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Daftar Produk",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          // ListView Builder untuk produk
          Expanded(
            child: ListView.builder(
              itemCount: produkList.length,
              itemBuilder: (context, index) {
                final item = produkList[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: Image.asset(
                      item.gambar,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item.nama),
                    subtitle: Text("${item.kategori} • Rp ${item.harga.toStringAsFixed(0)}"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailProduk(produk: item),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
//import 'package:cached_network_image/cached_network_image.dart';


class Beranda extends StatelessWidget {
  const Beranda({super.key});

  @override
  Widget build(BuildContext context) {
  final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final email = args?["email"] ?? "User";
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Beranda"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/login");
            },
          )
        ],
      ),
      
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            Stack(
              children: [
                Image.asset(
                  'assets/buri.jpeg', // Ganti dengan banner kamu
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Text(
                    "Selamat Datang $email",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [Shadow(blurRadius: 5, color: Colors.black)],
                    ),
                  ),
                ),
              ],
            ),

            // Menu Section
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Text(
                    'Menu Favorit',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    children: [
                      _menuCard('Mie Setan', 'assets/buri.jpeg'),
                      _menuCard('Mie Iblis', 'assets/mie iblis.jpg'),
                      _menuCard('Es Genderuwo', 'https://cnc-magazine.oramiland.com/parenting/images/Es_Genderewo.width-800.format-webp.webp'),
                      _menuCard('Pangsit Goreng', 'https://cnc-magazine.oramiland.com/parenting/images/Es_Genderewo.width-800.format-webp.webp'),
                    ],
                  ),
                ],
              ),
            ),

            // Promo Section
            /*Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '🔥 Promo Spesial!',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text('Diskon 20% untuk semua menu setiap hari Senin!'),
                      ],
                    ),
                  ),
                  Image.asset(
                    'assets/halim.jpg',
                    height: 60,
                  ),
                ],
              ),
            ),*/
          ],
        ),
      ),
    );
  }

  Widget _menuCard(String title, String imagePath) {
  
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.shade100,
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            /*child: imagePath(
              imageUrl : imageUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),*/

              child: Image.asset(
              imagePath,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}*/

/*import 'package:flutter/material.dart';

class Beranda extends StatelessWidget {
  const Beranda({super.key});

  final List<Map<String, String>> menuItems = const [
    {'title': 'Mie Setan', 'image': 'assets/buri.jpeg'},
    {'title': 'Mie Iblis', 'image': 'assets/mie iblis.jpg'},
    {'title': 'Mie Setan', 'image': 'assets/buri.jpeg'},
    {'title': 'Mie Iblis', 'image': 'assets/mie iblis.jpg'},
    {'title': 'Mie Setan', 'image': 'assets/buri.jpeg'},
    {'title': 'Mie Iblis', 'image': 'assets/mie iblis.jpg'},
    
  ];

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final email = args?["email"] ?? "User";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Beranda"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/login");
            },
          )
        ],
      ),
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            Stack(
              children: [
                Image.asset(
                  'assets/buri.jpeg',
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Text(
                    "Selamat Datang $email",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [Shadow(blurRadius: 5, color: Colors.black)],
                    ),
                  ),
                ),
              ],
            ),

            // Menu Section
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Text(
                    'Menu Favorit',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  GridView.builder(
                    itemCount: menuItems.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      final item = menuItems[index];
                      return _menuCard(item['title']!, item['image']!);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuCard(String title, String imagePath) {
    final isNetwork = imagePath.startsWith('http');
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.shade100,
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: isNetwork
                ? Image.network(
                    imagePath,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                  )
                : Image.asset(
                    imagePath,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}*/


