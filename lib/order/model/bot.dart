import 'package:equatable/equatable.dart';
import 'package:mcd_worker_demo/order/model/order.dart';

class Bot extends Equatable {
  const Bot({
    required this.id,
    this.assignedOrder,
    int? progress,
    bool? isVip,
  })  : progress = progress ?? 0,
        isVip = isVip ?? false;

  final int id;
  final Order? assignedOrder;
  final int progress;
  final bool isVip;

  Bot assignOrder({
    required Order newOrder,
  }) =>
      Bot(
        id: id,
        assignedOrder: newOrder,
        progress: progress,
        isVip: isVip,
      );

  Bot freeBot() => Bot(
        id: id,
        assignedOrder: null,
        progress: 0,
        isVip: isVip,
      );

  Bot increaseProgress(int tick) => Bot(
        id: id,
        assignedOrder: assignedOrder,
        progress: tick,
        isVip: isVip,
      );

  @override
  List<Object?> get props => [id, assignedOrder, progress, isVip];
}
