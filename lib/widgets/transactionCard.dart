import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Function _removeTransaction;

  TransactionCard(
      this.id, this.title, this.amount, this.date, this._removeTransaction);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 4,
      ),
      child: Container(
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: FittedBox(
                child: Text('\$$amount'),
              ),
            ),
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.title
          ),
          subtitle: Text(
            DateFormat('dd-MMM-yyyy').format(date),
          ),
          trailing: MediaQuery.of(context).size.width > 360
              ? FlatButton.icon(
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).errorColor,
                  ),
                  textColor: Theme.of(context).errorColor,
                  label: const Text('Delete'),
                  onPressed: () => _removeTransaction(id),
                )
              : IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).errorColor,
                  ),
                  onPressed: () => _removeTransaction(id),
                ),
        ),
      ),
    );
  }
}
