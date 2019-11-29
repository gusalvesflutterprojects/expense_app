import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transaction_list.dart';

class TransactionListContainer extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeTransaction;
  final String label;

  TransactionListContainer(
    this.transactions,
    this.removeTransaction,
    this.label,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            top: 24,
            right: 12,
            bottom: 12,
            left: 12,
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
              fontFamily: 'Helvetica',
              // shadows: [
              //   Shadow(
              //     blurRadius: 1,
              //     offset: Offset(4, 2),
              //     color: Colors.black26,
              //   ),
              // ],
            ),
          ),
        ),
        TransactionList(
          transactions,
          removeTransaction,
        ),
      ],
    );
  }
}
