import 'package:expenses_app/models/transaction.dart';
import 'package:expenses_app/widgets/new_transaction.dart';
import 'package:expenses_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.amberAccent,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((transaction) {
      return transaction.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses Planner'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(context)),
        ],
      ),
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(10),
            child: Card(
              color: Theme.of(context).primaryColor,
              child: Container(
                padding: EdgeInsets.all(5),
                child: Center(
                  child: Chart(_recentTransactions),
                ),
              ),
              elevation: 7,
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
            padding: EdgeInsets.all(12),
            child: (_userTransactions.isEmpty)
                ? Column(
                    children: [
                      Text(
                        'No transactions added yet',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 200,
                        child: Image.asset(
                          'assets/images/waiting.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  )
                : TransactionList(_userTransactions),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
