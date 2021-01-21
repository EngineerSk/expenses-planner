import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import '../widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));

      var totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; ++i) {
        if (recentTransactions[i].date.day == weekday.day &&
            recentTransactions[i].date.month == weekday.month &&
            recentTransactions[i].date.year == weekday.year)
          totalSum += recentTransactions[i].amount;
      }

      print(DateFormat.E().format(weekday));
      print(totalSum);
      return {'day': DateFormat.E().format(weekday), 'amount': totalSum};
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, transactionValues) {
      return sum += transactionValues['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(12.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((transactionValues) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                transactionValues['day'],
                transactionValues['amount'],
                totalSpending > 0.0
                    ? (transactionValues['amount'] as double) / totalSpending
                    : totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
