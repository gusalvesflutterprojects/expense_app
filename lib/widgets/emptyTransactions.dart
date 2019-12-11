import 'package:flutter/material.dart';

class EmptyTransactions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'No transactions added yet!',
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(
              bottom: mediaQuery.size.height * 0.1,
              top: mediaQuery.size.height * 0.05,
            ),
            //color: Colors.red,
            child: Image.asset(
              'assets/images/waiting.png',
              //fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
