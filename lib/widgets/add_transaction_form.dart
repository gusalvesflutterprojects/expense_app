import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class AddTransactionForm extends StatelessWidget {
  final Function addTransaction;

  final titleController = TextEditingController();
  final amountController = MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );

  AddTransactionForm(this.addTransaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
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
              onSubmitted: (_) => addTransaction,
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
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(2.0, 3.0),
                        blurRadius: 3.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ],
                  ),
                ),
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  addTransaction(
                    titleController.text,
                    double.parse(amountController.text.replaceAll(',', '')),
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
