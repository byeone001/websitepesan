import 'package:flutter/material.dart';
import 'package:websitepesan/halaman_buktitransaksi.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:websitepesan/providers/transaction_provider.dart';

class HalamanRiwayat extends StatelessWidget {
  const HalamanRiwayat({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final transactions = transactionProvider.transactions;

    return transactions.isEmpty
        ? const Center(
            child: Text('Belum ada riwayat transaksi.'),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaksi = transactions[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                elevation: 2,
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HalamanBuktiTransaksi(
                          keranjang: transaksi.keranjang,
                          email: transaksi.email,
                          idTransaksi: transaksi.idTransaksi,
                          waktuTransaksi: transaksi.waktuTransaksi,
                        ),
                      ),
                    );
                  },
                  title: Text('ID Transaksi: ${transaksi.idTransaksi}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tanggal: ${DateFormat('dd MMMM yyyy, HH:mm').format(transaksi.waktuTransaksi)}'),
                      Text('Total: Rp${transaksi.keranjang.totalHarga.toStringAsFixed(0)}'),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              );
            },
          );
  }
}