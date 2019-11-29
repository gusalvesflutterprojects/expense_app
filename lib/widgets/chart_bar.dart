import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: Column(
        children: <Widget>[
          Container(
            height: 20,
            child: FittedBox(
              child: Text(
                '\$${spendingAmount.toStringAsFixed(0)}',
                style: TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            height: 60,
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
          SizedBox(
            height: 4,
          ),
          Text(
            label,
          ),
        ],
      ),
    );
  }
}
