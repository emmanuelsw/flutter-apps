import 'dart:math';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {

  Color _selectedColor;

  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.black,
      Colors.blue,
      Colors.purple
    ];

    _selectedColor = availableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _selectedColor,
          radius: 30,
          child: Text(
            '\$${widget.transaction.amount.toStringAsFixed(2)}',
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date),
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
          onPressed: () => widget.deleteTransaction(widget.transaction.id),
        ),
      ),
    );
  }
}
