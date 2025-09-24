import 'package:flutter/material.dart';
import 'package:websitepesan/halaman_detailproduk.dart';
import 'package:websitepesan/model/dummydata.dart';
import 'package:websitepesan/model/keranjang.dart';
import 'package:websitepesan/model/produk.dart';

class HalamanBeranda extends StatelessWidget {
  final Keranjang keranjang;
  final String email;
  final Function(Produk) onAddToCart;

  const HalamanBeranda({
    super.key,
    required this.keranjang,
    required this.email,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    List<Produk> produkList = DummyData.getProdukList();

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
                'Diskon Rp 10.000 untuk pesanan di atas Rp 50.000',
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
                      onAddToCart(produk);
                    },
                  ),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HalamanDetail(
                          produk: produk,
                          onTambahKeKeranjang: () {
                            onAddToCart(produk);
                          },
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}