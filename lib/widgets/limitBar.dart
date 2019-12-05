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
          confirmTextStyle:
              TextStyle(color: Theme.of(context).primaryColor, fontSize: 18),
          cancelTextStyle:
              TextStyle(color: Theme.of(context).primaryColor, fontSize: 18),
          adapter: PickerDataAdapter<String>(pickerdata: ['Week', 'Month']),
          changeToFirst: true,
          textAlign: TextAlign.left,
          columnPadding: const EdgeInsets.all(8.0),
          onConfirm: (Picker picker, _) {
            changeTimeRangeName(picker.getSelectedValues()[0]);
          });
      picker.show(Scaffold.of(context));
    }

    return LayoutBuilder(
      builder: (ctx, cst) => Column(
        children: <Widget>[
          Container(
            height: cst.maxHeight * 0.6,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Amount spent',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('\$${totalSpending.toStringAsFixed(2)}'),
                    ],
                  ),
                ),
                SizedBox(
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: MediaQuery.of(context).size.height * 0.035,
                    icon: Icon(
                      Icons.swap_vertical_circle,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      showPicker(context);
                    },
                  ),
                ),
                // IconButton(
                //   padding: EdgeInsets.zero,
                //   icon: Icon(
                //     Icons.swap_vertical_circle,
                //     size: 28,
                //     color: Theme.of(context).primaryColorDark,
                //   ),
                //   onPressed: () {
                //     showPicker(context);
                //   },
                // ),
                Expanded(
                  child: FlatButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => startUpdateLimitValue(context),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '${timeRangeName[0].toUpperCase()}${timeRangeName.substring(1)} limit',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('\$${limitValue.toStringAsFixed(2)} '),
                            Icon(
                              Icons.edit,
                              size: 18,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: cst.maxHeight * 0.1,
          ),
          Container(
            height: cst.maxHeight * 0.3,
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
      ),
    );
  }
}
