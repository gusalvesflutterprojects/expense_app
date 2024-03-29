import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartBar extends StatelessWidget {
  final DateTime day;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.day, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (ctx, cst) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: cst.maxHeight * 0.15,
              child: FittedBox(
                child: Text(
                  '\$${spendingAmount.toStringAsFixed(0)}',
                  //style: TextStyle(fontSize: 16, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              height: cst.maxHeight * 0.55,
              width: 10,
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 1.0,
                      ),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor:
                        spendingPctOfTotal.isNaN ? 0 : spendingPctOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: cst.maxHeight * 0.25,
              child: Column(
                children: <Widget>[
                  Text(
                    DateFormat.E().format(day).substring(0, 3),
                  ),
                  Text(DateFormat('dd').format(day)),
                ],
              ),
            ),
          ],
        );},
      );
}
