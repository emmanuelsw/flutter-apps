import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatefulWidget {
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  final List<Transaction> _transactions = [
    Transaction(
      id: 't1',
      title: 'Scanner',
      amount: 99.98,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't1',
      title: 'さくら学院 Photo Sets',
      amount: 18.55,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
    );
  }
}