enum ItemCategory {
  makanan,
  minuman,
  snack,
}

class Item {
  const Item({
    required this.nama,
    required this.harga,
    this.category = ItemCategory.makanan,
    this.photo,
  });

  final String nama;
  final int harga;
  final Uri? photo;
  final ItemCategory category;
}

class Cart {
  Cart({
    this.items = const [],
  });

  List<Item> items;

  int total() {
    return items.map((e) => e.harga).fold(0, (prev, curr) => prev + curr);
  }
}
