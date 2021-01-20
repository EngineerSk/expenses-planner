import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;

  TransactionList(this._transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            elevation: 9,
            child: Container(
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green,
                        width: 3,
                      ),
                    ),
                    child: Text(
                      '\$ ${_transactions[index].amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _transactions[index].title,
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        DateFormat().format(_transactions[index].date.toUtc()),
                        style: TextStyle(color: Colors.grey),
                        textAlign: TextAlign.start,
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: _transactions.length,
      ),
    );
  }
}
