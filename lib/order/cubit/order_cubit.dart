import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mcd_worker_demo/order/model/order.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderState(orderCount: 0, orders: const []));

  void addOrder({bool isVip = false}) {
    int updatedCount = state.orderCount + 1;
    Order newOrder = Order(id: updatedCount, isVip: isVip);

    // Copy last state list
    List<Order> updatedList = List.from(state.orders);
    // Sort accordingly if VIP
    int vipCount = updatedList.where((order) => order.isVip).length;
    if (isVip) {
      updatedList.insert(vipCount, newOrder);
    } else {
      updatedList.add(newOrder);
    }
    emit(OrderState(orderCount: updatedCount, orders: updatedList));
  }
}
