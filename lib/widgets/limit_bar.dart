import 'package:flutter/material.dart';

class LimitBar extends StatelessWidget {
  final double totalSpending;
  final double limitValue;
  final limitColor;

  LimitBar(this.totalSpending, this.limitValue, this.limitColor);

  @override
  Widget build(BuildContext context) {
    return Column(
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
                          color: limitColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}