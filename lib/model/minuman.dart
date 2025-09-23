import 'package:websitepesan/model/produk.dart';

class Minuman extends Produk {
  final bool dingin;
  final String ukuran;

  Minuman({
    required String id,
    required String nama,
    required String deskripsi,
    required double harga,
    required String gambar,
    required double rating,
    required this.dingin,
    required this.ukuran,
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
    String infoSuhu = dingin ? "Dingin" : "Hangat";
    return "$nama ($infoSuhu, $ukuran) - Rp${harga.toStringAsFixed(0)}";
  }
}