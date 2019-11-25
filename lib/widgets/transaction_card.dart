import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final String title;
  final double amount;
  final DateTime date;

  TransactionCard(this.title, this.amount, this.date);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        child: Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
                borderRadius: BorderRadius.all(Radius.zero),
                border: Border.all(
                  color: Theme.of(context).primaryColorDark,
                  width: 2.0,
                ),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Text(
                    '\$${RegExp(r"(\d+)(?=\.)").stringMatch(amount.toStringAsFixed(2))}',
                    style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: 18),
                  ),
                  Text(
                    '${RegExp(r"\.(\d+)").stringMatch(amount.toStringAsFixed(2))}',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context).textTheme.title
                ),
                Text(
                  DateFormat('dd MMM yyyy').format(date),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Colors.black45
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
