import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      var total = 0.0;

      for (var transaction in recentTransactions) {
        if (transaction.date.day == weekday.day &&
            transaction.date.month == weekday.month &&
            transaction.date.year == weekday.year) {
          total += transaction.amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': total
      };
    }).reversed.toList();
  }

  double get maxValue {
    List amounts = [];

    for (var tx in groupedTransactions) {
      amounts.add(tx['amount']);
    }
    return amounts.reduce((curr, next) => curr > next ? curr : next);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.all(15),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            for (var data in groupedTransactions)
              Expanded(
                child: ChartBar(
                  data['day'],
                  data['amount'],
                  maxValue == 0.0 ? 0.0 : (data['amount'] as double) / maxValue,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
