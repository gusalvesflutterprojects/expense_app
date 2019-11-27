import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class AddTransactionForm extends StatefulWidget {
  final Function addTransaction;

  AddTransactionForm(this.addTransaction);

  @override
  _AddTransactionFormState createState() => _AddTransactionFormState();
}

class _AddTransactionFormState extends State<AddTransactionForm> {
  final titleController = TextEditingController();

  final amountController = MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );

  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              onSubmitted: (_) => widget.addTransaction,
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              children: <Widget>[
                Text('Pick a date'),
                SizedBox(width: 12,),
                FlatButton(
                  onPressed: () {
                    DatePicker.showDatePicker(
                      context,
                      showTitleActions: true,
                      minTime: DateTime.now().subtract(
                        Duration(days: 30),
                      ),
                      maxTime: DateTime.now(),
                      onChanged: (date) => setState(() => _selectedDate = date),
                      onConfirm: (date) {
                        setState(() => _selectedDate = date);
                      },
                      currentTime: _selectedDate,
                      locale: LocaleType.pt,
                    );
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
                            .format(_selectedDate)
                            .toString(),
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
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
                  style: TextStyle(shadows: <Shadow>[
                    // Shadow(
                    //   offset: Offset(2.0, 3.0),
                    //   blurRadius: 3.0,
                    //   color: Color.fromARGB(255, 0, 0, 0),
                    // ),
                  ], color: Theme.of(context).textTheme.button.color),
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
    );
  }
}
