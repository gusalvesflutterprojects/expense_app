import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './chartBar.dart';
import './limitBar.dart';

class Chart extends StatefulWidget {
  final List<Transaction> rangeTransactions;
  final DateTime firstDay;
  final double limitValue;
  final Function startUpdateLimitValue;
  final String timeRangeName;
  final Function changeTimeRangeName;

  Chart(
    this.rangeTransactions,
    this.firstDay,
    this.limitValue,
    this.startUpdateLimitValue,
    this.timeRangeName,
    this.changeTimeRangeName,
  );

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(widget.timeRangeName == 'week' ? 7 : 30,
      (index) {
        double totalSum = 0.0;

        final weekDay = widget.firstDay.add(
          Duration(
            days: index,
          ),
        );

        for (var i = 0; i < widget.rangeTransactions.length; i++) {
          if (widget.rangeTransactions[i].date.day == weekDay.day &&
              widget.rangeTransactions[i].date.month == weekDay.month &&
              widget.rangeTransactions[i].date.year == weekDay.year)
            totalSum += widget.rangeTransactions[i].amount;
        }

        return {
          'day': weekDay,
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
    else if (_totalSpending <= widget.limitValue / 100 * 50)
      return Colors.lightGreenAccent;
    else if (_totalSpending <= widget.limitValue / 100 * 80)
      return Colors.yellowAccent;
    else
      return Colors.redAccent;
  }

  @override
  Widget build(BuildContext context) {
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
              width: MediaQuery.of(context).size.width * 1,
              height: 144,
              padding: EdgeInsets.all(12),
              child: ListView(
                scrollDirection: Axis.horizontal,
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
              widget.limitValue,
              _limitColor,
              widget.startUpdateLimitValue,
              widget.timeRangeName,
              widget.changeTimeRangeName,
            ),
          ],
        ),
      ),
    );
  }
}
