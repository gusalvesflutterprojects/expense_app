import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  String _formatOrdinalDay(int val) {
    switch (val) {
      case 1:
        return '1st';
      case 2:
        return '2nd';
      case 3:
        return '3rd';
        break;
      default:
        return '${val}th';
    }
  }

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(
      widget.timeRangeName == 'week' ? 7 : 30,
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

  bool get isLandscape =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.all(20),
      child: Container(
        height: !isLandscape
            ? MediaQuery.of(context).size.height * 0.35
            : MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            // Add one stop for each color. Stops should increase from 0 to 1
            stops: [.3, .6],
            colors: [
              _limitColor,
              Colors.white,
            ],
          ),
        ),
        child: LayoutBuilder(
          builder: (ctx, cst) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: cst.maxHeight * 0.1,
                child: Text(
                  widget.timeRangeName == 'week'
                      ? 'Week of ${DateFormat('MMMM').format(widget.firstDay)} ${_formatOrdinalDay(widget.firstDay.day)}'
                      : '${DateFormat('MMMM').format(DateTime.now())}',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Container(
                height: cst.maxHeight * 0.55,
                child: LayoutBuilder(
                  builder: (ctx, cst) => ListView(
                    semanticChildCount: 7,
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      ...groupedTransactionValues
                          .map(
                            (data) => Container(
                              width: cst.maxWidth * 0.142857143,
                              child: ChartBar(
                                data['day'],
                                data['amount'],
                                (data['amount'] as double) / _totalSpending,
                              ),
                            ),
                          )
                          .toList()
                    ],
                  ),
                ),
              ),
              Container(
                height: cst.maxHeight * 0.35,
                child: LimitBar(
                  _totalSpending,
                  widget.limitValue,
                  _limitColor,
                  widget.startUpdateLimitValue,
                  widget.timeRangeName,
                  widget.changeTimeRangeName,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
