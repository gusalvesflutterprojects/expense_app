import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../models/transaction.dart';
import '../widgets/transaction_card.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: transactions.length > 0
          ? ListView.builder(
              itemBuilder: (
                ctx,
                index,
              ) {
                final tx = transactions[index];
                return TransactionCard(
                  tx.title,
                  tx.amount,
                  tx.date,
                );
              },
              itemCount: transactions.length,
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                ),
                Container(
                  height: 350,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
    );
  }
}
