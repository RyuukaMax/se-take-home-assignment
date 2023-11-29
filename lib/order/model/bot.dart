import 'package:equatable/equatable.dart';
import 'package:mcd_worker_demo/order/model/order.dart';

class Bot extends Equatable {
  const Bot({
    required this.id,
    this.assignedOrder,
    int? progress,
  }) : progress = progress ?? 0;

  final int id;
  final Order? assignedOrder;
  final int progress;

  Bot assignOrder({
    required Order newOrder,
  }) =>
      Bot(
        id: id,
        assignedOrder: newOrder,
        progress: progress,
      );

  Bot freeBot() => Bot(
        id: id,
        assignedOrder: null,
        progress: 0,
      );

  Bot increaseProgress(int tick) => Bot(
        id: id,
        assignedOrder: assignedOrder,
        progress: tick,
      );

  @override
  List<Object?> get props => [id, assignedOrder, progress];
}
