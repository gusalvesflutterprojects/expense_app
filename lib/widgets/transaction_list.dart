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
    return Expanded(
      child: transactions.length > 0
          ? ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (
                ctx,
                index,
              ) {
                return TransactionCard(
                  transactions[index].id,
                  transactions[index].title,
                  transactions[index].amount,
                  transactions[index].date,
                  removeTransaction,
                );
              },
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                ),
                SizedBox(
                  height: 10,
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

class Teste extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('teste'));
  }
}
