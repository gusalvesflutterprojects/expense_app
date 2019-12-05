import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

class LimitBar extends StatelessWidget {
  final double totalSpending;
  final double limitValue;
  final limitColor;
  final Function startUpdateLimitValue;
  final String timeRangeName;
  final Function changeTimeRangeName;

  LimitBar(
    this.totalSpending,
    this.limitValue,
    this.limitColor,
    this.startUpdateLimitValue,
    this.timeRangeName,
    this.changeTimeRangeName,
  );

  @override
  Widget build(BuildContext context) {
    void showPicker(BuildContext context) {
      Picker picker = Picker(
        confirmTextStyle: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18),
        cancelTextStyle: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18),
          adapter: PickerDataAdapter<String>(pickerdata: ['Week', 'Month']),
          changeToFirst: true,
          textAlign: TextAlign.left,
          columnPadding: const EdgeInsets.all(8.0),
          onConfirm: (Picker picker, _) {
            changeTimeRangeName(picker.getSelectedValues()[0]);
          });
      picker.show(Scaffold.of(context));
    }

    return Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  'Amount spent',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text('\$${totalSpending.toStringAsFixed(2)}'),
                ),
              ],
            ),
            IconButton(
              icon: Icon(
                Icons.swap_vertical_circle,
                size: 28,
                color: Theme.of(context).primaryColorDark,
              ),
              onPressed: () {
                showPicker(context);
              },
            ),
            Column(
              children: <Widget>[
                Text(
                  '${timeRangeName[0].toUpperCase()}${timeRangeName.substring(1)} limit',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  children: <Widget>[
                    FlatButton(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: Row(
                        children: <Widget>[
                          Text('\$${limitValue.toStringAsFixed(2)} '),
                          Icon(
                            Icons.edit,
                            size: 18,
                          ),
                        ],
                      ),
                      onPressed: () => startUpdateLimitValue(context),
                    ),
                  ],
                )
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
                widthFactor: totalSpending / limitValue > 1
                    ? 1
                    : totalSpending / limitValue,
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
