import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mcd_worker_demo/order/model/bot.dart';
import 'package:mcd_worker_demo/order/model/order.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(const OrderState());

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
    emit(state.copyWith(
      orderCount: updatedCount,
      pendingOrders: newPendingOrders,
    ));
    processOrder();
  }

  void addBot() {
    int updatedCount = state.botCount + 1;
    Bot newBot = Bot(id: updatedCount);

    // Copy last state list
    List<Bot> newBots = List.from(state.bots);
    newBots.add(newBot);
    emit(state.copyWith(
      botCount: updatedCount,
      bots: newBots,
    ));
    processOrder();
  }

  void deleteBot() {
    if (state.bots.isEmpty) {
      return;
    }

    List<Bot> newBots = List.from(state.bots);
    newBots.removeLast();
    emit(state.copyWith(
      bots: newBots,
    ));
  }

  Future<void> processOrder() async {
    late Bot updatedBot;
    late Order updatedOrder;
    bool isBotAlive = true;

    Bot? getFreeBot =
        state.bots.where((bot) => bot.assignedOrder == null).firstOrNull;

    Order? latestPendingOrder = state.pendingOrders
        .where((order) => order.status == Status.pending)
        .firstOrNull;

    // Check if there is a free bot and a pending order
    if (getFreeBot == null || latestPendingOrder == null) {
      return;
    } else {
      // Assigned order to bot
      updatedBot = getFreeBot.assignOrder(newOrder: latestPendingOrder);
      // Update order status to process
      updatedOrder = latestPendingOrder.processOrder();
      // Replace older items with items with newer properties
      emit(state.copyWith(
        bots: _updateBotListState(
          List.from(state.bots),
          getFreeBot,
          updatedBot,
        ),
        pendingOrders: _updateOrderListState(
          List.from(state.pendingOrders),
          latestPendingOrder,
          updatedOrder,
        ),
      ));

      await Stream<int>.periodic(const Duration(seconds: 1), (i) => i + 1)
          .takeWhile((event) {
        isBotAlive = state.bots.contains(updatedBot);
        return event < 5 && isBotAlive;
      }).forEach((element) {});

      if (isBotAlive) {
        // Update order list
        state.pendingOrders.remove(updatedOrder);
        List<Order> completedList = List.from(state.completedOrders);
        completedList.add(updatedOrder.completeOrder());

        // Replace older items with items with newer properties
        emit(state.copyWith(
          bots: _updateBotListState(
            List.from(state.bots),
            updatedBot,
            updatedBot.freeBot(),
          ),
          completedOrders: completedList,
        ));

        processOrder();
      } else {
        // Replace older items with items with newer properties
        emit(state.copyWith(
          pendingOrders: _updateOrderListState(
            List.from(state.pendingOrders),
            updatedOrder,
            updatedOrder.cancelOrder(),
          ),
        ));
      }
    }
  }

  /// Replace order with older properties with newer properties in the list
  List<Order> _updateOrderListState(
    List<Order> list,
    Order original,
    Order updated,
  ) {
    int index = list.indexOf(original);
    list.remove(original);
    list.insert(index, updated);
    return list;
  }

  /// Replace bot with older properties with newer properties in the list
  List<Bot> _updateBotListState(
    List<Bot> list,
    Bot original,
    Bot updated,
  ) {
    int index = list.indexOf(original);
    list.remove(original);
    list.insert(index, updated);
    return list;
  }
}
