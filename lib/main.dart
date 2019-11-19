import 'package:flutter/material.dart';

import './transaction.dart';
import 'transactionCard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
      id: 't1',
      title: 'New shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'New pajamas',
      amount: 80.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'New waifu pillow',
      amount: 40.99,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Card(
              color: Colors.red,
              child: Text('This is the chart'),
            ),
          ),
          Column(
            children: <Widget>[
              ...transactions
                  .map(
                    (tx) => TransactionCard(tx.title, tx.amount, tx.date),
                  ),
            ],
          ),
        ],
      ),
    );
  }
}
