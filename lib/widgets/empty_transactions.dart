import 'package:flutter/material.dart';

class EmptyTransactions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'No transactions added yet!',
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 350,
          child: Image.asset(
            'assets/images/waiting.png',
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
