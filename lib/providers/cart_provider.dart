import 'package:flutter/material.dart';
import '../models/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class NotificationModel {
  final String title;
  final String message;
  final DateTime time;

  NotificationModel({required this.title, required this.message, required this.time});
}

class OrderModel {
  final String id;
  final List<CartItem> items;
  final double total;
  final DateTime date;
  final String status; // 'Diproses', 'Dikirim', 'Selesai'

  OrderModel({
    required this.id,
    required this.items,
    required this.total,
    required this.date,
    this.status = 'Diproses',
  });
}

class CartProvider extends ChangeNotifier {
  final Map<String, CartItem> _items = {};
  final List<Product> _favoriteItems = [];
  final List<NotificationModel> _notifications = [];
  final List<OrderModel> _orders = [];

  // === CART LOGIC ===
  List<CartItem> get cartItems => _items.values.toList();

  int get itemCount => _items.length;

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.product.price * cartItem.quantity;
    });
    return total;
  }

  void addToCart(Product product) {
    if (_items.containsKey(product.name)) {
      _items.update(
        product.name,
        (existingItem) => CartItem(
          product: existingItem.product,
          quantity: existingItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.name,
        () => CartItem(product: product),
      );
    }
    notifyListeners();
  }

  void removeItem(String productName) {
    _items.remove(productName);
    notifyListeners();
  }

  void removeSingleItem(String productName) {
    if (!_items.containsKey(productName)) return;
    if (_items[productName]!.quantity > 1) {
      _items.update(
        productName,
        (existingItem) => CartItem(
          product: existingItem.product,
          quantity: existingItem.quantity - 1,
        ),
      );
    } else {
      _items.remove(productName);
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  // === FAVORITE LOGIC ===
  List<Product> get favoriteItems => _favoriteItems;

  bool isFavorite(Product product) {
    return _favoriteItems.any((item) => item.name == product.name);
  }

  void toggleFavorite(Product product) {
    final index = _favoriteItems.indexWhere((item) => item.name == product.name);
    if (index >= 0) {
      _favoriteItems.removeAt(index);
    } else {
      _favoriteItems.add(product);
    }
    notifyListeners();
  }

  // === NOTIFICATION LOGIC ===
  List<NotificationModel> get notifications => _notifications;

  void addNotification(String title, String message) {
    _notifications.insert(0, NotificationModel(
      title: title,
      message: message,
      time: DateTime.now(),
    ));
    notifyListeners();
  }

  // === ORDER LOGIC ===
  List<OrderModel> get orders => _orders;

  void addOrder() {
    if (_items.isEmpty) return;
    
    _orders.insert(0, OrderModel(
      id: 'ORD-${DateTime.now().millisecondsSinceEpoch}',
      items: cartItems,
      total: totalAmount,
      date: DateTime.now(),
    ));
    
    clearCart();
    notifyListeners();
  }
}
