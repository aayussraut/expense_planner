import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function removeTransaction;
  TransactionList(this._userTransactions, this.removeTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
              margin: EdgeInsets.all(8),
              child: ListTile(
                leading: CircleAvatar(
                  child: FittedBox(
                      child: Text('\$${_userTransactions[index].amount}')),
                ),
                title: Text('${_userTransactions[index].title}'),
                subtitle: Text(
                  DateFormat.yMMMd().format(_userTransactions[index].date),
                ),
                trailing: IconButton(
                  onPressed: () =>
                      removeTransaction(_userTransactions[index].id),
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ));
        },
        itemCount: _userTransactions.length,
      ),
    );
    // _userTransactions.map((tx) {
    //   return Card(
    //       margin: EdgeInsets.all(8),
    //       child: ListTile(
    //         leading: CircleAvatar(
    //           child: Text('\$${tx.amount}'),
    //         ),
    //         title: Text('${tx.title}'),
    //         subtitle: Text('${tx.date}'),
    //       ));
    // }).toList(),
    // );
  }
}
