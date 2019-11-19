import 'package:expense_app/addTransactionForm.dart';
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

  void addTransaction(Transaction tx) {
    transactions.add(tx);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Card(
              color: Colors.red,
              child: Text('This is the chart'),
            ),
          ),
          Card(
            child: Container(
              padding: EdgeInsets.all(12),
              child: 
                  AddTransactionForm(addTransaction),
            ),
          ),
          Column(
            children: <Widget>[
              ...transactions.map(
                (tx) => TransactionCard(tx.title, tx.amount, tx.date),
              ),
            ],
          ),
        ],
      ),
    );
  }
}