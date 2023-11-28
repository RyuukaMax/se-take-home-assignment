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

  @override
  List<Object?> get props => [id, isVip, status];
}

enum Status {
  pending,
  completed;
}
