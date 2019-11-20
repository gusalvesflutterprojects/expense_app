import 'package:expense_app/widgets/add_transaction_form.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import './models/transaction.dart';
import './widgets/chart.dart';
import './widgets/transaction_list.dart';

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

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
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

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: AddTransactionForm(
            _addTransaction,
          ),
        );
      },
    );
  }

  void _addTransaction(String txTitle, double txAmount) {
    if (txTitle.isNotEmpty && txAmount > 0) {
      final newTx = Transaction(
        id: Random().nextInt(999999999).toString(),
        title: txTitle,
        amount: txAmount,
        date: DateTime.now(),
      );
      setState(() => _transactions.add(newTx));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Chart(),
          TransactionList(
            _transactions,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.orange[700],
        elevation: 1,
        onPressed: () => _startAddNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
