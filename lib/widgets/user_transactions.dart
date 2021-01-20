import 'package:expenses_app/models/transaction.dart';
import 'package:expenses_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

import 'new_transaction.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
    Transaction(id: 't1', title: 'shoes', amount: 69.99, date: DateTime.now()),
    Transaction(id: 't2', title: 'hoodies', amount: 35.75, date: DateTime.now())
  ];

  void _addNewTransaction(String title, double amount) {
    setState(() {
      _userTransactions.add(Transaction(
          id: DateTime.now().toString(),
          title: title,
          amount: amount,
          date: DateTime.now()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          child: NewTransaction(_addNewTransaction),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
          padding: EdgeInsets.all(12),
          child: TransactionList(_userTransactions),
        )
      ],
    );
  }
}
