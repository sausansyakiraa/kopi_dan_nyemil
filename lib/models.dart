import 'package:flutter/material.dart';

enum MenuCategory { minuman, makanan }

class MenuItem {
  final String id;
  final String name;
  final List<String> details;
  final int price;
  final IconData icon;
  final MenuCategory category;

  const MenuItem({
    required this.id,
    required this.name,
    required this.details,
    required this.price,
    required this.icon,
    required this.category,
  });
}

class AppUser {
  String fullName;
  final String username;
  final String password;

  AppUser({
    required this.fullName,
    required this.username,
    required this.password,
  });
}

class DeliveryAddress {
  final String fullName;
  final String address;
  final String detail;

  const DeliveryAddress({
    required this.fullName,
    required this.address,
    this.detail = '',
  });
}

/// Data statis (dummy), tanpa database.
const List<MenuItem> dummyMenu = [
  MenuItem(
    id: 'm1',
    name: 'Kopi Susu Gula Aren',
    details: ['Espresso, susu, gula aren'],
    price: 22000,
    icon: Icons.coffee,
    category: MenuCategory.minuman,
  ),
  MenuItem(
    id: 'm2',
    name: 'Donat Cokelat',
    details: ['Donat empuk, glaze cokelat'],
    price: 12000,
    icon: Icons.donut_large,
    category: MenuCategory.makanan,
  ),
  MenuItem(
    id: 'm3',
    name: 'Sourdough Loaf',
    details: ['Roti fermentasi alami'],
    price: 35000,
    icon: Icons.bakery_dining,
    category: MenuCategory.makanan,
  ),
  MenuItem(
    id: 'm4',
    name: 'Cappuccino',
    details: ['Espresso, foam susu lembut'],
    price: 25000,
    icon: Icons.coffee_maker,
    category: MenuCategory.minuman,
  ),
  MenuItem(
    id: 'm5',
    name: 'Matcha Latte',
    details: ['Matcha Jepang, susu segar'],
    price: 27000,
    icon: Icons.emoji_food_beverage,
    category: MenuCategory.minuman,
  ),
  MenuItem(
    id: 'm6',
    name: 'Croissant Almond',
    details: ['Croissant renyah, taburan almond'],
    price: 24000,
    icon: Icons.breakfast_dining,
    category: MenuCategory.makanan,
  ),
  MenuItem(
    id: 'm7',
    name: 'Es Americano',
    details: ['Espresso, air, es batu'],
    price: 18000,
    icon: Icons.local_cafe,
    category: MenuCategory.minuman,
  ),
  MenuItem(
    id: 'm8',
    name: 'Banana Bread',
    details: ['Roti pisang lembut, sedikit kayu manis'],
    price: 20000,
    icon: Icons.cake,
    category: MenuCategory.makanan,
  ),
];

/// Mengubah 22000 menjadi "Rp 22.000".
String formatRupiah(int value) {
  final s = value.toString();
  final buf = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
    buf.write(s[i]);
  }
  return 'Rp $buf';
}