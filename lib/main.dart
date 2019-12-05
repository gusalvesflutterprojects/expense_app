import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'dart:math';

import './widgets/chart.dart';
import './models/transaction.dart';
import './widgets/emptyTransactions.dart';
import './widgets/addTransactionForm.dart';
import './widgets/transactionListContainer.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

var uuid = Uuid();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'Helvetica',
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  fontFamily: 'Helvetica',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              button: TextStyle(
                color: Colors.white,
              ),
              body1: TextStyle(
                fontFamily: 'SanFrancisco',
              ),
            ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            fontFamily: 'SanFrancisco',
          ),
        ),
        primarySwatch: Colors.purple,
        accentColor: Colors.greenAccent,
        errorColor: Colors.red[700],
      ),
      title: 'Expenses App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    ScrollController _controller = ScrollController();

  void _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {}
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        _shouldShowChart = true;
      });
    }
  }

  bool _shouldShowChart = true;
  String orderBy = 'mostRecent';
  String _timeRangeName = 'month';
  Map _limitValues = {
    'month': 1000,
    'week': 200,
  };
  //double _limitValue = 1000;
  final List<Transaction> _transactions = [
    Transaction(
      id: uuid.v1(),
      title: 'New shoes',
      amount: (Random().nextDouble() * 200).floorToDouble(),
      date: DateTime.now(),
    ),
    Transaction(
      id: uuid.v1(),
      title: 'New pajamas',
      amount: (Random().nextDouble() * 200).floorToDouble(),
      date: DateTime.now().subtract(Duration(days: Random().nextInt(30))),
    ),
    Transaction(
      id: uuid.v1(),
      title: 'New pajamas',
      amount: (Random().nextDouble() * 200).floorToDouble(),
      date: DateTime.now().subtract(Duration(days: Random().nextInt(30))),
    ),
    Transaction(
      id: uuid.v1(),
      title: 'New pajamas',
      amount: (Random().nextDouble() * 200).floorToDouble(),
      date: DateTime.now().subtract(Duration(days: Random().nextInt(30))),
    ),
    Transaction(
      id: uuid.v1(),
      title: 'New pajamas',
      amount: (Random().nextDouble() * 200).floorToDouble(),
      date: DateTime.now().subtract(Duration(days: Random().nextInt(30))),
    ),
    Transaction(
      id: uuid.v1(),
      title: 'New pajamas',
      amount: (Random().nextDouble() * 200).floorToDouble(),
      date: DateTime.now().subtract(Duration(days: Random().nextInt(30))),
    ),
    Transaction(
      id: uuid.v1(),
      title: 'New pajamas',
      amount: (Random().nextDouble() * 200).floorToDouble(),
      date: DateTime.now().subtract(Duration(days: Random().nextInt(30))),
    ),
    Transaction(
      id: uuid.v1(),
      title: 'New pajamas',
      amount: (Random().nextDouble() * 200).floorToDouble(),
      date: DateTime.now().subtract(Duration(days: Random().nextInt(30))),
    ),
    Transaction(
      id: uuid.v1(),
      title: 'New pajamas',
      amount: (Random().nextDouble() * 200).floorToDouble(),
      date: DateTime.now().subtract(Duration(days: Random().nextInt(30))),
    ),
    Transaction(
      id: uuid.v1(),
      title: 'New pajamas',
      amount: (Random().nextDouble() * 200).floorToDouble(),
      date: DateTime.now().subtract(Duration(days: Random().nextInt(30))),
    ),
    Transaction(
      id: uuid.v1(),
      title: 'New waifu pillow',
      amount: (Random().nextDouble() * 200).floorToDouble(),
      date: DateTime.now().subtract(Duration(days: Random().nextInt(30))),
    ),
    Transaction(
      id: uuid.v1(),
      title: 'New waifu pillow',
      amount: (Random().nextDouble() * 200).floorToDouble(),
      date: DateTime.now().subtract(Duration(days: Random().nextInt(30))),
    ),
    Transaction(
      id: uuid.v1(),
      title: 'New waifu pillow',
      amount: (Random().nextDouble() * 200).floorToDouble(),
      date: DateTime.now().subtract(Duration(days: Random().nextInt(30))),
    ),
    Transaction(
      id: uuid.v1(),
      title: 'New waifu pillow',
      amount: (Random().nextDouble() * 200).floorToDouble(),
      date: DateTime.now().subtract(Duration(days: Random().nextInt(30))),
    ),
    Transaction(
      id: uuid.v1(),
      title: 'Before date',
      amount: (Random().nextDouble() * 200).floorToDouble(),
      date: DateTime.now().subtract(Duration(days: Random().nextInt(30))),
    ),
  ];

  List<Transaction> get _orderedTransactions {
    if (orderBy == 'mostRecent')
      _transactions.sort((a, b) => b.date.compareTo(a.date));
    else
      _transactions.sort((a, b) => a.date.compareTo(b.date));

    return _transactions;
  }

  void _reorderTransactions(String orderType) =>
      setState(() => orderBy = orderType);

  final limitController = MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );

  DateTime get _firstDay {
    if (_timeRangeName == 'week') {
      int sundayWeekdayNum = 7;
      DateTime lastSunday = DateTime.now();

      while (lastSunday.weekday != sundayWeekdayNum) {
        lastSunday = lastSunday.subtract(Duration(days: 1));
      }

      return lastSunday;
    } else {
      return DateTime(DateTime.now().year, DateTime.now().month, 1);
    }
  }

  List<Transaction> get _rangeTransactions {
    if (_timeRangeName == 'week')
      return _orderedTransactions
          .where(
            (tx) =>
                tx.date.isAfter(
                  _firstDay.subtract(
                    Duration(days: 1),
                  ),
                ) &&
                tx.date.isBefore(
                  DateTime.now(),
                ),
          )
          .toList();
    else
      return _orderedTransactions
          .where(
            (tx) =>
                tx.date.isAfter(
                    DateTime(DateTime.now().year, DateTime.now().month, 0)) &&
                tx.date.isBefore(
                    DateTime(DateTime.now().year, DateTime.now().month + 1, 1)),
          )
          .toList();
  }

  List<Transaction> get _otherTransactions {
    return _orderedTransactions
        .where(
          (tx) => tx.date.isBefore(
            _firstDay.subtract(
              Duration(days: 1),
            ),
          ),
        )
        .toList();
  }

  void _changeTimeRangeName(String newRangeName) =>
      setState(() => _timeRangeName = newRangeName.toLowerCase());

  void _startUpdateLimitValue(BuildContext ctx) {
    showDialog(
      context: ctx,
      child: SimpleDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        title: Text(
          'Type new value',
          style: Theme.of(context).textTheme.title,
        ),
        titlePadding: EdgeInsets.all(16),
        contentPadding: EdgeInsets.all(0),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 42,
              horizontal: 24,
            ),
            child: TextField(
              autofocus: true,
              controller: limitController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Amount"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: FlatButton(
              color: Theme.of(context).primaryColor,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Icon(
                Icons.save_alt,
                color: Colors.white,
              ),
              onPressed: () {
                final double newLimitValue = double.parse(
                  limitController.text.replaceAll(',', ''),
                );
                if (newLimitValue != 0) {
                  setState(() => _limitValues.update(
                      _timeRangeName, (_) => newLimitValue));
                  limitController.updateValue(0);
                  Navigator.of(context).pop();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: AddTransactionForm(
            _addTransaction,
            _firstDay,
          ),
        );
      },
    );
  }

  void _addTransaction(
    String txTitle,
    double txAmount,
    DateTime txDate,
  ) {
    if (txTitle.isNotEmpty && txAmount > 0) {
      final newTx = Transaction(
        id: uuid.v1(),
        title: txTitle,
        amount: txAmount,
        date: txDate,
      );
      setState(
        () => _transactions.add(newTx),
      );

      Navigator.of(context).pop();
    }
  }

  void _removeTransaction(String txId) {
    setState(
      () => _transactions.removeWhere(
        (tx) => tx.id == txId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _controller.addListener(_scrollListener);

    final AppBar appBar = AppBar(
      title: Text(
        'Expenses App',
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add,
          ),
          onPressed: () {},
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Switch(
          //   value: _shouldShowChart,
          //   onChanged: (val) => setState(() => _shouldShowChart = val),),
          _shouldShowChart
              ? GestureDetector(
                  onVerticalDragStart: (_) =>
                      setState(() => _shouldShowChart = !(_shouldShowChart)),
                  child: Chart(
                    _rangeTransactions,
                    _firstDay,
                    _limitValues[_timeRangeName].toDouble(),
                    _startUpdateLimitValue,
                    _timeRangeName,
                    _changeTimeRangeName,
                  ),
                )
              : Container(),
          Expanded(
            child:
                _rangeTransactions.length > 0 || _otherTransactions.length > 0
                    ? ListView(
                        controller: _controller,
                        children: <Widget>[
                          _rangeTransactions.length > 0
                              ? TransactionListContainer(
                                  transactions: _rangeTransactions,
                                  removeTransaction: _removeTransaction,
                                  reorderTransactions: _reorderTransactions,
                                  label:
                                      '${_timeRangeName[0].toUpperCase()}${_timeRangeName.substring(1)} spendings',
                                  isMain: true,
                                )
                              : Container(), // ? Render nothing
                          _otherTransactions.length > 0
                              ? TransactionListContainer(
                                  transactions: _otherTransactions,
                                  removeTransaction: _removeTransaction,
                                  reorderTransactions: _reorderTransactions,
                                  label: 'Other spendings',
                                )
                              : Container(), // ? Render nothing,
                        ],
                      )
                    : EmptyTransactions(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: () => {
          Navigator.of(context).popUntil(
            ModalRoute.withName("/"),
          ),
          _startAddNewTransaction(context)
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
