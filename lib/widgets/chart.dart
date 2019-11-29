import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './chart_bar.dart';
import './limit_bar.dart';

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

  double get _totalSpending {
    return groupedTransactionValues.fold(
        0.0, (sum, item) => sum + item['amount']);
  }

  get _limitColor {
    if (_totalSpending == 0)
      return Color.fromRGBO(220, 220, 220, 1);
    else if (_totalSpending <= limitValue / 100 * 50)
      return Colors.lightGreenAccent;
    else if (_totalSpending <= limitValue / 100 * 80)
      return Colors.yellowAccent;
    else
      return Colors.redAccent;
  }

  @override
  Widget build(BuildContext context) {
    
    print('=========_limitColor: ${_limitColor}');
    
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            // Add one stop for each color. Stops should increase from 0 to 1
            stops: [.3, .6],
            colors: [
              // Colors are easy thanks to Flutter's Colors class.
              _limitColor,
              Colors.white,
            ],
          ),
        ),
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
                          (data['amount'] as double) / _totalSpending,
                        ),
                      )
                      .toList()
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            LimitBar(
              _totalSpending,
              limitValue,
              _limitColor,
            ),
          ],
        ),
      ),
    );
  }
}
