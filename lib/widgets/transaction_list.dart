import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../widgets/transaction_card.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeTransaction;

  TransactionList(
    this.transactions,
    this.removeTransaction,
  );
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      ...transactions.map(
        (tx) {
          return TransactionCard(
            tx.id,
            tx.title,
            tx.amount,
            tx.date,
            removeTransaction,
          );
        },
      ).toList()
    ]);
  }
}

class Teste extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('teste'));
  }
}
