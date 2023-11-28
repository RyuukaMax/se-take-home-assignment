import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mcd_worker_demo/order/model/order.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit()
      : super(const OrderState(
          orderCount: 0,
          pendingOrders: [],
          completedOrders: [],
        ));

  void addOrder({bool isVip = false}) {
    int updatedCount = state.orderCount + 1;
    Order newOrder = Order(id: updatedCount, isVip: isVip);

    // Copy last state list
    List<Order> newPendingOrders = List.from(state.pendingOrders);
    // Sort accordingly if VIP
    if (isVip) {
      int vipCount = newPendingOrders.where((order) => order.isVip).length;
      newPendingOrders.insert(vipCount, newOrder);
    } else {
      newPendingOrders.add(newOrder);
    }
    emit(OrderState(
      orderCount: updatedCount,
      pendingOrders: newPendingOrders,
      completedOrders: state.completedOrders,
    ));
  }
}
