import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double amount;
  final String day;
  final double pctOfSpending;
  ChartBar(
      {required this.amount, required this.day, required this.pctOfSpending});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text('$amount'),
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
              ),
              FractionallySizedBox(
                heightFactor: pctOfSpending,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all(
                    //   width: 1.0,
                    // ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(day),
      ],
    );
  }
}
