import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> weekTransactions;
  final DateTime firstDay;
  final double limitValue;

  Chart(this.weekTransactions, this.firstDay, this.limitValue);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(
      7,
      (index) {
        double totalSum = 0.0;

        final weekDay = firstDay.add(
          Duration(
            days: index,
          ),
        );

        for (var i = 0; i < weekTransactions.length; i++) {
          if (weekTransactions[i].date.day == weekDay.day &&
              weekTransactions[i].date.month == weekDay.month &&
              weekTransactions[i].date.year == weekDay.year)
            totalSum += weekTransactions[i].amount;
        }

        return {
          'day': DateFormat.E().format(weekDay).substring(0, 3),
          'amount': totalSum,
        };
      },
    ).toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(
        0.0, (sum, item) => sum + item['amount']);
  }

  get _limitColor {
    if (totalSpending <= limitValue / 100 * 50)
      return Colors.lightGreenAccent;
    else if (totalSpending <= limitValue / 100 * 80)
      return Colors.yellowAccent;
    else
      return Colors.redAccent;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ...groupedTransactionValues
                    .map(
                      (data) => ChartBar(
                        data['day'],
                        data['amount'],
                        (data['amount'] as double) / totalSpending,
                      ),
                    )
                    .toList()
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text('Amount spent',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold)),
                      Text('\$${totalSpending.toStringAsFixed(2)}'),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        'Week limit',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Text('\$${limitValue.toStringAsFixed(2)}'),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 18,
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(220, 220, 220, 1),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: totalSpending / limitValue,
                      child: Container(
                        decoration: BoxDecoration(
                          color: _limitColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
