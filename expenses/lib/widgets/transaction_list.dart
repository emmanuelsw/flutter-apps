import 'package:flutter/material.dart';
import '../widgets/transaction_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  Widget _noContent(BuildContext context) {
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

  Widget _transactionList(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return TransactionItem(transactions[index], deleteTransaction);
      },
      itemCount: transactions.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 390,
        child: transactions.isEmpty
            ? _noContent(context)
            : _transactionList(context),
      ),
    );
  }
}