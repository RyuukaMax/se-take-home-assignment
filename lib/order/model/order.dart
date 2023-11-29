import 'package:equatable/equatable.dart';

class Order extends Equatable {
  const Order({
    required this.id,
    bool? isVip,
    Status? status,
  })  : isVip = isVip ?? false,
        status = status ?? Status.pending;

  final int id;
  final bool isVip;
  final Status status;

  Order cancelOrder() => Order(id: id, isVip: isVip, status: Status.pending);

  Order processOrder() =>
      Order(id: id, isVip: isVip, status: Status.processing);

  Order completeOrder() =>
      Order(id: id, isVip: isVip, status: Status.completed);

  @override
  List<Object?> get props => [id, isVip, status];
}

enum Status {
  pending,
  processing,
  completed;
}
