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
                color: Colors.purple[100],
                borderRadius: BorderRadius.all(Radius.zero),
                border: Border.all(
                  color: Colors.purple,
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
                    '\$${RegExp(r"(\d+)(?=\.)").stringMatch(amount.toString())}',
                    style: TextStyle(
                        fontFamily: 'ubuntu',
                        color: Colors.deepPurple,
                        fontSize: 18),
                  ),
                  Text(
                    '${RegExp(r"\.(\d+)").stringMatch(amount.toString())}',
                    style: TextStyle(color: Colors.deepPurple[400]),
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
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
