import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitData() {
    final title = titleController.text;
    final amount = double.parse(amountController.text);

    if (title.isEmpty || amount <= 0) {
      return;
    }

    widget.addTransaction(title, amount);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.only(right: 20, left: 20),
        child: Column(
          children: <Widget>[
            TextField(
              controller: titleController,
              onSubmitted: (_) => submitData(),
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
            ),
            RaisedButton(
              child: Text('Add Transaction'),
              onPressed: submitData,
              color: Colors.blue[500],
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
