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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expense'),
        actions: [
          IconButton(
            onPressed: () => _startAddTransaction(context),
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Chart(recentTransaction),
            TransactionList(transactions, removeTransaction),
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
