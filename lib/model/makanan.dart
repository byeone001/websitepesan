import 'package:websitepesan/model/produk.dart';

class Makanan extends Produk {
  final bool pedas;
  final String kategori;

  Makanan({
    required String id,
    required String nama,
    required String deskripsi,
    required double harga,
    required String gambar,
    required double rating,
    required this.pedas,
    required this.kategori,
  }) : super(
          id: id,
          nama: nama,
          deskripsi: deskripsi,
          harga: harga,
          gambar: gambar,
          rating: rating,
        );

  // Override method tampilkanInfo (polimorfisme)
  @override
  String tampilkanInfo() {
    String infoPedas = pedas ? "Pedas" : "Tidak Pedas";
    return "$nama ($infoPedas) - Rp${harga.toStringAsFixed(0)}";
  }
}
