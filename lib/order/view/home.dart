import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcd_worker_demo/order/cubit/order_cubit.dart';
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
            margin: const EdgeInsets.all(32.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: BlocBuilder<OrderCubit, OrderState>(
              builder: (context, state) => _createOrderTile(state.orders),
            ),
          ),
        ),
        ElevatedButton(
          child: const Text('Add Order'),
          onPressed: () => context.read<OrderCubit>().addOrder(),
        ),
        ElevatedButton(
          child: const Text('Add Order VIP'),
          onPressed: () => context.read<OrderCubit>().addOrder(isVip: true),
        )
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
        ),
      );
}
