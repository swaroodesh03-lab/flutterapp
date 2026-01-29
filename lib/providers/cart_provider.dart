import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'personalization_provider.dart';

class CartItem {
  final String id;
  final String bookTitle;
  final double price;
  final PersonalizationState personalization;

  CartItem({
    required this.id,
    required this.bookTitle,
    required this.price,
    required this.personalization,
  });
}

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addItem(String bookTitle, double price, PersonalizationState personalization) {
    state = [
      ...state,
      CartItem(
        id: DateTime.now().toString(),
        bookTitle: bookTitle,
        price: price,
        personalization: personalization,
      ),
    ];
  }

  void removeItem(String id) {
    state = state.where((item) => item.id != id).toList();
  }

  double get total => state.fold(0, (sum, item) => sum + item.price);

  void clear() => state = [];
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});
