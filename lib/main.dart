import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/chart.dart';
import 'package:expense_planner/widgets/newTransaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import '../models/transaction.dart';
import '../widgets/userTransaction.dart';
import '../widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Personal Expense",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [];

  List<Transaction> get recentTransaction {
    return transactions.where((tx) {
      return (tx.date.isAfter(DateTime.now().subtract(Duration(days: 7))));
    }).toList();
  }

  void _addTransaction(String id, String title, double amount, DateTime date) {
    final newTx = Transaction(
      id: id,
      date: date,
      amount: amount,
      title: title,
    );

    setState(() {
      transactions.add(newTx);
    });
  }

  void removeTransaction(String id) {
    setState(() {
      transactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return NewTransaction(_addTransaction);
      },
    );
  }

  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appbar = AppBar(
      title: Text('Personal Expense'),
      actions: [
        IconButton(
          onPressed: () => _startAddTransaction(context),
          icon: Icon(Icons.add),
        )
      ],
    );
    final txWidget = Container(
      height: MediaQuery.of(context).size.height * 0.7 -
          appbar.preferredSize.height -
          MediaQuery.of(context).padding.top,
      child: TransactionList(transactions, removeTransaction),
    );

    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Show Chart"),
                  Switch(
                      value: _switchValue,
                      onChanged: (value) {
                        setState(() {
                          _switchValue = value;
                        });
                      })
                ],
              ),
            if (!isLandscape)
              Container(
                height: MediaQuery.of(context).size.height * 0.3 -
                    appbar.preferredSize.height -
                    MediaQuery.of(context).padding.top,
                child: Chart(recentTransaction),
              ),
            if (!isLandscape) txWidget,
            if (isLandscape)
              _switchValue
                  ? Container(
                      height: MediaQuery.of(context).size.height * 0.7 -
                          appbar.preferredSize.height -
                          MediaQuery.of(context).padding.top,
                      child: Chart(recentTransaction),
                    )
                  : txWidget,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
