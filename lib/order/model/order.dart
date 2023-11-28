class Order {
  Order({required this.id, bool? isVip}) : isVip = isVip ?? false;

  final int id;
  final bool isVip;
}
