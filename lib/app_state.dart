import 'package:flutter/foundation.dart';

import 'models.dart';

/// State aplikasi sederhana (tanpa package tambahan, tanpa database).
class AppState extends ChangeNotifier {
  // Akun demo supaya bisa langsung login: demo / 123456
  final List<AppUser> _users = [
    AppUser(fullName: 'Demo User', username: 'demo', password: '123456'),
  ];

  AppUser? currentUser;
  DeliveryAddress? address;
  String orderNote = '';
  final Map<String, int> cart = {};
  int tabIndex = 0;

  String get displayName => currentUser?.fullName ?? 'Nama';

  void saveAddress(DeliveryAddress a) {
    address = a;
    notifyListeners();
  }

  void setOrderNote(String note) {
    orderNote = note;
  }

  void clearOrderNote() {
    orderNote = '';
    notifyListeners();
  }

  /// Mengembalikan pesan error, atau null jika berhasil.
  String? register(String fullName, String username, String password) {
    final u = username.trim().toLowerCase();
    if (_users.any((e) => e.username == u)) {
      return 'Username sudah dipakai';
    }
    final user = AppUser(
      fullName: fullName.trim(),
      username: u,
      password: password,
    );
    _users.add(user);
    currentUser = user;
    _resetSession();
    return null;
  }

  /// Mengembalikan pesan error, atau null jika berhasil.
  String? login(String username, String password) {
    final u = username.trim().toLowerCase();
    for (final user in _users) {
      if (user.username == u && user.password == password) {
        currentUser = user;
        _resetSession();
        return null;
      }
    }
    return 'Username atau password salah';
  }

  void logout() {
    currentUser = null;
    _resetSession();
  }

  void updateName(String name) {
    currentUser?.fullName = name.trim();
    notifyListeners();
  }

  void setTab(int index) {
    tabIndex = index;
    notifyListeners();
  }

  void addToCart(MenuItem item) {
    cart[item.id] = (cart[item.id] ?? 0) + 1;
    notifyListeners();
  }

  void removeFromCart(MenuItem item) {
    final q = cart[item.id] ?? 0;
    if (q <= 1) {
      cart.remove(item.id);
    } else {
      cart[item.id] = q - 1;
    }
    notifyListeners();
  }

  void clearCart() {
    cart.clear();
    notifyListeners();
  }

  int get totalItems => cart.values.fold(0, (a, b) => a + b);

  int get totalPrice {
    var sum = 0;
    for (final item in dummyMenu) {
      sum += (cart[item.id] ?? 0) * item.price;
    }
    return sum;
  }

  void _resetSession() {
    cart.clear();
    address = null;
    orderNote = '';
    tabIndex = 0;
    notifyListeners();
  }
}

/// Satu objek yang dipakai seluruh aplikasi.
final AppState appState = AppState();