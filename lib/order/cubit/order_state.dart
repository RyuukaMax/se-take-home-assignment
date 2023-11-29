part of 'order_cubit.dart';

class OrderState extends Equatable {
  const OrderState({
    int? orderCount,
    int? botCount,
    List<Order>? pendingOrders,
    List<Order>? completedOrders,
    List<Bot>? bots,
  })  : orderCount = orderCount ?? 0,
        botCount = botCount ?? 0,
        pendingOrders = pendingOrders ?? const [],
        completedOrders = completedOrders ?? const [],
        bots = bots ?? const [];

  final int orderCount;
  final int botCount;
  final List<Order> pendingOrders;
  final List<Order> completedOrders;
  final List<Bot> bots;

  OrderState copyWith({
    int? orderCount,
    int? botCount,
    List<Order>? pendingOrders,
    List<Order>? completedOrders,
    List<Bot>? bots,
  }) =>
      OrderState(
        orderCount: orderCount ?? this.orderCount,
        botCount: botCount ?? this.botCount,
        pendingOrders: pendingOrders ?? this.pendingOrders,
        completedOrders: completedOrders ?? this.completedOrders,
        bots: bots ?? this.bots,
      );

  @override
  List<Object> get props => [orderCount, pendingOrders, completedOrders, bots];
}
