import 'package:flutter/material.dart';
import 'package:kasir/pages/transaksi_page.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const TransaksiPage(),
    );
  }
}
