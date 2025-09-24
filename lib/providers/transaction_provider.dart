import 'package:flutter/material.dart';
import 'package:websitepesan/model/transaksi.dart';

class TransactionProvider with ChangeNotifier {
  final List<Transaksi> _transactions = [];

  List<Transaksi> get transactions => List.unmodifiable(_transactions);

  void addTransaction(Transaksi transaction) {
    _transactions.add(transaction);
    notifyListeners();
  }
}
