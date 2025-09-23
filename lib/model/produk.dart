

class Produk {
  final String id;
  final String nama;
  final String deskripsi;
  final double harga;
  final String gambar;
  final double rating;

  Produk({
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.harga,
    required this.gambar,
    required this.rating,
  });

  // Method untuk menampilkan info produk (akan di-override oleh subclass)
  String tampilkanInfo() {
    return "$nama - Rp${harga.toStringAsFixed(0)}";
  }
}



/*class Produk {
  String _nama;
  String _kategori;
  double _harga;
  String _gambar;

  Produk({
    required String nama,
    required String kategori,
    required double harga,
    required String gambar,
  })  : _nama = nama,
        _kategori = kategori,
        _harga = harga,
        _gambar = gambar;

  // Getter & Setter → contoh enkapsulasi
  String get nama => _nama;
  set nama(String value) => _nama = value;

  String get kategori => _kategori;
  set kategori(String value) => _kategori = value;

  double get harga => _harga;
  set harga(double value) {
    if (value > 0) {
      _harga = value;
    }
  }

  String get gambar => _gambar;
  set gambar(String value) => _gambar = value;

  // Method default (akan dioverride child class → polymorphism)
  String deskripsi() {
    return "Produk umum: $_nama, kategori $_kategori, harga Rp $_harga";
  }
}*/