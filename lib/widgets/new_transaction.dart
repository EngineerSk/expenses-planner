import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function _addTransaction;

  NewTransaction(this._addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  void submitData() {
    final enteredTitle =  _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if(enteredTitle.isEmpty || enteredAmount <= 0) {
      Navigator.of(context).pop();
      return;
    }

    this.widget._addTransaction(enteredTitle, enteredAmount);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              keyboardType: TextInputType.text,
              onSubmitted:(_)=>submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted:(_)=>submitData(),
            ),
            FlatButton(
              onPressed: submitData,
              child: Text(
                'Add transaction',
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
