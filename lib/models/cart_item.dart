class CartItem {
  final String id;
  final String productId;
  final String name;
  final int amount;
  final double price;


  CartItem({
    required this.id, 
    required this.productId, 
    required this.name, 
    required this.amount, 
    required this.price
  });
}