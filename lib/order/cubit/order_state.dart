part of 'order_cubit.dart';

class OrderState extends Equatable {
  const OrderState({
    required this.orderCount,
    required this.pendingOrders,
    required this.completedOrders,
  });

  final int orderCount;
  final List<Order> pendingOrders;
  final List<Order> completedOrders;

  @override
  List<Object> get props => [orderCount, pendingOrders, completedOrders];
}
