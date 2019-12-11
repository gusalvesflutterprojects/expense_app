import 'package:flutter/material.dart';

import '../widgets/transactionListContainer.dart';
import '../widgets/emptyTransactions.dart';
import '../models/transaction.dart';

class TransactionListWrapper extends StatelessWidget {
  final List<Transaction> rangeTransactions, otherTransactions;
  final Function removeTransaction, reorderTransactions;
  final String timeRangeName;

  TransactionListWrapper(
    this.rangeTransactions,
    this.otherTransactions,
    this.removeTransaction,
    this.reorderTransactions,
    this.timeRangeName,
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: rangeTransactions.length > 0 || otherTransactions.length > 0
          ? ListView(
              children: <Widget>[
                rangeTransactions.length > 0
                    ? TransactionListContainer(
                        transactions: rangeTransactions,
                        removeTransaction: removeTransaction,
                        reorderTransactions: reorderTransactions,
                        label:
                            '${timeRangeName[0].toUpperCase()}${timeRangeName.substring(1)} spendings',
                        isMain: true,
                      )
                    : Container(), // ? Render nothing,
                otherTransactions.length > 0
                    ? TransactionListContainer(
                        transactions: otherTransactions,
                        removeTransaction: removeTransaction,
                        reorderTransactions: reorderTransactions,
                        label: 'Other spendings',
                      )
                    : Container(), // ? Render nothing,
              ],
            )
          : EmptyTransactions(),
    );
  }
}
