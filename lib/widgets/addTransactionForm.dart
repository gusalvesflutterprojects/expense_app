import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'adaptiveFlatButton.dart';

class AddTransactionForm extends StatefulWidget {
  final Function addTransaction;
  final DateTime firstDay;

  AddTransactionForm(this.addTransaction, this.firstDay);

  @override
  _AddTransactionFormState createState() => _AddTransactionFormState();
}

class _AddTransactionFormState extends State<AddTransactionForm> {
  final titleController = TextEditingController();
  final amountController = MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );
  final _focusAmount = FocusNode();
  final _focusSubmit = FocusNode();

  DateTime _selectedDate = DateTime.now();

  void _showDatePicker() {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: widget.firstDay,
      maxTime: DateTime.now(),
      onConfirm: (date) {
        setState(() => _selectedDate = date);
        FocusScope.of(context).requestFocus(_focusSubmit);
      },
      currentTime: _selectedDate,
      locale: LocaleType.pt,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
              top: 12,
              left: 12,
              right: 12,
              bottom: MediaQuery.of(context).viewInsets.bottom + 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: titleController,
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: "Title"),
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_focusAmount),
              ),
              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                focusNode: _focusAmount,
                decoration: InputDecoration(labelText: "Amount"),
                onFieldSubmitted: (_) => _showDatePicker(),
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: <Widget>[
                  Text('Pick a date'),
                  SizedBox(
                    width: 12,
                  ),
                  AdaptiveFlatButton(
                    'Choose date',
                    _showDatePicker,
                    _selectedDate,
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                  vertical: 24,
                ),
                child: FlatButton(
                  child: Text(
                    'Add transaction',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.button.color,
                    ),
                  ),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    widget.addTransaction(
                      titleController.text,
                      double.parse(amountController.text.replaceAll(',', '')),
                      _selectedDate,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
