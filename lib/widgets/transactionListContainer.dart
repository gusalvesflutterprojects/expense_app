import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transactionList.dart';

class TransactionListContainer extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeTransaction;
  final Function reorderTransactions;
  final String label;
  final bool isMain;

  TransactionListContainer({
    @required this.transactions,
    @required this.removeTransaction,
    @required this.reorderTransactions,
    @required this.label,
    this.isMain = false
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            top: isMain ? 0 : 24,
            right: 12,
            bottom: 12,
            left: 12,
          ),
          child: ListTile(
            contentPadding: EdgeInsets.only(
              left: 12,
              right: 24
            ),
            leading: Text(
              label, // ? XXXXX Spendings
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
                fontFamily: 'Helvetica',
              ),
            ),
            trailing: isMain
                ? DropdownButtonHideUnderline(
                    child: DropdownButton(
                      onChanged: (value) {
                        reorderTransactions(value);
                      },
                      icon: Icon(Icons.sort),
                      items: [
                        DropdownMenuItem(
                          value: "mostRecent",
                          child: Text(
                            "Most recent",
                          ),
                        ),
                        DropdownMenuItem(
                          value: "oldest",
                          child: Text(
                            "Oldest",
                          ),
                        ),
                      ],
                    ),
                  )
                : null,
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
