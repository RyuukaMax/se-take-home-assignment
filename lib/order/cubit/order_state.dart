part of 'order_cubit.dart';

class OrderState extends Equatable {
  OrderState({required this.orderCount, required this.orders});

  final int orderCount;
  final List<Order> orders;

  @override
  List<Object> get props => [orders];
}
