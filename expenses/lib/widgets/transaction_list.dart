import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  Widget noContent(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 30),
        Text(
          'No transactions added yet!',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        SizedBox(height: 30),
        Container(
          height: 200,
          child: Image.asset(
            'assets/images/waiting.png',
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget transactionList(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Text(
                '\$${transactions[index].amount.toStringAsFixed(2)}',
              ),
            ),
            title: Text(
              transactions[index].title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              DateFormat.yMMMd().format(transactions[index].date),
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
              onPressed: () => deleteTransaction(transactions[index].id),
            ),
          ),
        );
      },
      itemCount: transactions.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 390,
      child: transactions.isEmpty ? noContent(context) : transactionList(context),
    );
  }
}
