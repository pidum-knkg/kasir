import 'package:flutter/material.dart';
import 'package:kasir/pages/transaksi_page.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    super.key,
    required this.items,
  });

  final List<ItemCount> items;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final WidgetsToImageController _toImageController =
      WidgetsToImageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("CETAK"),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: WidgetsToImage(
                controller: _toImageController,
                child: SafeArea(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          "Selaras",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          "jl Buah Mangga 3 no 23",
                          textAlign: TextAlign.center,
                        ),
                        const Text(
                          "23423423498732982734",
                          textAlign: TextAlign.center,
                        ),
                        for (var item in widget.items
                            .where((element) => element.count > 0))
                          ListTile(
                            onTap: () {},
                            contentPadding: const EdgeInsets.all(0),
                            dense: true,
                            minVerticalPadding: 0,
                            title: Text(item.item.nama),
                            subtitle: Row(
                              children: [
                                Text("${item.count}"),
                                const Text(" x "),
                                Text("Rp ${item.item.harga}"),
                                const Spacer(),
                                Text("Rp ${item.count * item.item.harga}"),
                              ],
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            children: [
                              const Text("Total"),
                              const Spacer(),
                              Text(
                                  "Rp ${widget.items.fold(0, (previousValue, element) => previousValue + (element.count * element.item.harga))}"),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FractionalTranslation(
              translation: const Offset(0, -.3),
              child: ElevatedButton(
                onPressed: () async {
                  var bytes = await _toImageController.capture();
                  if (bytes != null && mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Image.memory(bytes),
                      ),
                    );
                  }
                },
                child: const Text("CETAK"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
