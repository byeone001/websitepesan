
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:websitepesan/providers/transaction_provider.dart';

class HalamanProfil extends StatelessWidget {
  final String email;
  const HalamanProfil({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(flex: 2, child: _BagianAtas(email: email)),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'Halo, $email',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton.extended(
                      onPressed: () {},
                      elevation: 0,
                      label: const Text("Kamu Sudah Melakukan Transaksi"),
                      icon: const Icon(Icons.person_add_alt_1),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _BarisInfoProfil(email: email), //
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _BarisInfoProfil extends StatelessWidget {
  final String email;
  const _BarisInfoProfil({required this.email});

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, transactionProvider, child) {
        final transactionCount = transactionProvider.transactionsForUser(email).length;
        final List<ItemInfoProfil> items = [
          ItemInfoProfil("Jumlah Transaksi", transactionCount),
        ];

        return Container(
          height: 80,
          constraints: const BoxConstraints(maxWidth: 400),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: items
                .map(
                  (item) => Expanded(
                    child: Row(
                      children: [
                        if (items.indexOf(item) != 0) const VerticalDivider(),
                        Expanded(child: _itemTunggal(context, item)),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }

  Widget _itemTunggal(BuildContext context, ItemInfoProfil item) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.nilai.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Text(item.judul, style: Theme.of(context).textTheme.bodySmall),
        ],
      );
}

class ItemInfoProfil {
  final String judul;
  final int nilai;
  const ItemInfoProfil(this.judul, this.nilai);
}

class _BagianAtas extends StatelessWidget {
  final String email;
  const _BagianAtas({required this.email});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Color(0xff0043ba), Color(0xff006df1)],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
