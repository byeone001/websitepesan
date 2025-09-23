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
/*import 'package:cobacoba/model/produk.dart';

class Makanan extends Produk {
  Makanan({
    required String nama,
    required double harga,
    required String gambar,
  }) : super(nama: nama, kategori: "Makanan", harga: harga, gambar: gambar);

  @override
  String deskripsi() {
    return "Makanan spesial: $nama, Harga: Rp $harga";
  }
}

class Minuman extends Produk {
  Minuman({
    required String nama,
    required double harga,
    required String gambar,
  }) : super(nama: nama, kategori: "Minuman", harga: harga, gambar: gambar);

  @override
  String deskripsi() {
    return "Minuman segar: $nama, Harga: Rp $harga";
  }
}*/