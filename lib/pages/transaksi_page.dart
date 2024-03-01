import 'package:flutter/material.dart';
import 'package:kasir/data.dart';
import 'package:kasir/models.dart';
import 'package:kasir/pages/cart_page.dart';

class ItemCount {
  ItemCount({
    required this.item,
    this.count = 0,
  });

  final Item item;
  int count;
}

class TransaksiPage extends StatefulWidget {
  const TransaksiPage({super.key});

  @override
  State<TransaksiPage> createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  late List<ItemCount> _items;
  ItemCategory _category = ItemCategory.makanan;

  @override
  void initState() {
    super.initState();
    setState(() {
      _items = items.map((e) => ItemCount(item: e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildButtons(),
          _buildItems(),
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CartPage(items: _items)));
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      shape: const BeveledRectangleBorder(
        side: BorderSide(
          color: Colors.black38,
          width: .3,
        ),
      ),
      leading: const Icon(Icons.list),
      centerTitle: true,
      title: const Text("TRANSAKSI BARU"),
      actions: const [
        Icon(Icons.badge),
        SizedBox(
          width: 8,
        )
      ],
    );
  }

  Widget _buildButtons() {
    return Material(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Wrap(
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          runAlignment: WrapAlignment.start,
          spacing: 5,
          children: [
            ChoiceChip(
              showCheckmark: false,
              label: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: _category == ItemCategory.makanan
                        ? const BorderSide(color: Colors.black)
                        : BorderSide.none,
                  ),
                ),
                child: const Text("Makanan"),
              ),
              side: BorderSide.none,
              selected: _category == ItemCategory.makanan,
              onSelected: (value) {
                if (value) {
                  setState(() {
                    _category = ItemCategory.makanan;
                  });
                }
              },
            ),
            ChoiceChip(
              showCheckmark: false,
              label: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: _category == ItemCategory.minuman
                        ? const BorderSide(color: Colors.black)
                        : BorderSide.none,
                  ),
                ),
                child: const Text("Minuman"),
              ),
              side: BorderSide.none,
              selected: _category == ItemCategory.minuman,
              onSelected: (value) {
                if (value) {
                  setState(() {
                    _category = ItemCategory.minuman;
                  });
                }
              },
            ),
            ChoiceChip(
              showCheckmark: false,
              label: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: _category == ItemCategory.snack
                        ? const BorderSide(color: Colors.black)
                        : BorderSide.none,
                  ),
                ),
                child: const Text("Snack"),
              ),
              side: BorderSide.none,
              selected: _category == ItemCategory.snack,
              onSelected: (value) {
                if (value) {
                  setState(() {
                    _category = ItemCategory.snack;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Expanded _buildItems() {
    return Expanded(
      child: ClipRRect(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ListView(
            clipBehavior: Clip.none,
            children: _items
                .where((element) => element.item.category == _category)
                .map((e) => ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      onTap: () {
                        setState(() {
                          e.count++;
                        });
                      },
                      leading: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          SizedBox.square(
                            dimension: 40,
                            child: Container(color: Colors.black),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: Visibility(
                              visible: e.count > 0,
                              child: FractionalTranslation(
                                translation: const Offset(-.5, .5),
                                child: Badge(
                                  label: Text("${e.count}"),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      title: Text(
                        e.item.nama,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("Rp ${e.item.harga}"),
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            if (e.count > 0) {
                              e.count--;
                            }
                          });
                        },
                        icon: const Icon(Icons.clear),
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
