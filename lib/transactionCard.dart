import 'package:flutter/material.dart';

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
              child: Text(
                '\$$amount',
                style: TextStyle(
                    fontFamily: 'ubuntu', color: Colors.deepPurple, fontSize: 18),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title),
                Text('${date.day}/${date.month}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
