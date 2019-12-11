import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class AdaptiveFlatButton extends StatefulWidget {
  final String label;
  final Function showDatePicker;
  final DateTime selectedDate;

  AdaptiveFlatButton(
    this.label,
    this.showDatePicker,
    this.selectedDate,
  );

  @override
  _AdaptiveFlatButtonState createState() => _AdaptiveFlatButtonState();
}

class _AdaptiveFlatButtonState extends State<AdaptiveFlatButton> {
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: () {
              widget.showDatePicker();
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.calendar_today,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  DateFormat("dd 'de' MMM 'de' yyyy")
                      .format(widget.selectedDate)
                      .toString(),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        : FlatButton(
            onPressed: () {
              widget.showDatePicker();
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.calendar_today,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  DateFormat("dd 'de' MMM 'de' yyyy")
                      .format(widget.selectedDate)
                      .toString(),
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
  }
}
