import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get recentTransactionList {
    return List.generate(7, (index) {
      var weekDays = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        if (weekDays.day == recentTransaction[i].date.day) {
          if (weekDays.month == recentTransaction[i].date.month) {
            if (weekDays.year == recentTransaction[i].date.year) {
              totalSum += recentTransaction[i].amount;
            }
          }
        }
      }

      return {
        'day': DateFormat.E().format(weekDays).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get recentTransactionSum {
    return recentTransactionList.fold(0.0, (sum, tx) {
      sum = sum + (tx['amount'] as double);
      return sum;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(9),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: recentTransactionList.map((tx) {
            return ChartBar(
              amount: tx['amount'] as double,
              day: tx['day'] as String,
              pctOfSpending: recentTransactionSum == 0.0
                  ? 0.0
                  : ((tx['amount'] as double) / recentTransactionSum),
            );
          }).toList(),
        ),
      ),
    );
  }
}
