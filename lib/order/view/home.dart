import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcd_worker_demo/order/cubit/order_cubit.dart';
import 'package:mcd_worker_demo/order/model/bot.dart';
import 'package:mcd_worker_demo/order/model/order.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo Queue App'),
      ),
      body: BlocProvider(
        create: (context) => OrderCubit(),
        child: const _Home(),
      ),
    );
  }
}

class _Home extends StatefulWidget {
  const _Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<_Home> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 15.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: BlocBuilder<OrderCubit, OrderState>(
              builder: (context, state) =>
                  _createOrderRow(state.pendingOrders, state.completedOrders),
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 15.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: BlocBuilder<OrderCubit, OrderState>(
                builder: (context, state) => Column(
                      children: <Widget>[
                        const Text('Bot List'),
                        Expanded(
                          child: _createBotTile(state.bots),
                        ),
                      ],
                    )),
          ),
        ),
        ElevatedButton(
          child: const Text('Add Order'),
          onPressed: () => context.read<OrderCubit>().addOrder(),
        ),
        ElevatedButton(
          child: const Text('Add Order VIP'),
          onPressed: () => context.read<OrderCubit>().addOrder(isVip: true),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          child: const Text('Add Bot'),
          onPressed: () => context.read<OrderCubit>().addBot(),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          child: const Text('Delete Bot'),
          onPressed: () => context.read<OrderCubit>().deleteBot(),
        ),
      ],
    );
  }

  _createOrderRow(List<Order> pendingOrders, List<Order> completedOrders) =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: _createOrderColumn(pendingOrders, Status.pending),
          ),
          Expanded(
            child: _createOrderColumn(completedOrders, Status.completed),
          ),
        ],
      );

  _createOrderColumn(List<Order> props, Status status) {
    return Column(
      children: <Widget>[
        Text(status == Status.pending ? 'Pending' : 'Completed'),
        Expanded(
          child: _createOrderTile(props),
        ),
      ],
    );
  }

  _createOrderTile(List<Order> props) => ListView.separated(
        separatorBuilder: (context, index) => const Divider(),
        itemCount: props.length,
        itemBuilder: (_, index) => ListTile(
          title: Text(
            '#${props[index].id.toString()} ${props[index].isVip ? "VIP Order" : "Normal Order"}',
          ),
          subtitle: Text(props[index].status.toString()),
        ),
      );

  _createBotTile(List<Bot> props) => ListView.separated(
        separatorBuilder: (context, index) => const Divider(),
        itemCount: props.length,
        itemBuilder: (_, index) => ListTile(
          title: Text(
            '#${props[index].id.toString()} Working Bot',
          ),
          subtitle: props[index].assignedOrder != null
              ? Text('Working on order ${props[index].assignedOrder!.id}')
              : const Text('No work'),
        ),
      );
}
