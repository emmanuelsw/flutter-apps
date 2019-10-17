import 'dart:io';

import 'package:flutter/material.dart';
import './models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expenses App',
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.red,
          fontFamily: 'Quicksand'),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _transactions = [
    Transaction(
      id: 't1',
      title: 'Scanner',
      amount: 39.98,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'さくら学院 Photo Sets',
      amount: 88.55,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: 't3',
      title: 'さくら学院 Magazine',
      amount: 18.55,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: 't4',
      title: 'さくら学院 RTG',
      amount: 72.55,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: 't5',
      title: 'さくら学院 GakuinSai',
      amount: 60.55,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 't6',
      title: 'さくら学院 Photobook',
      amount: 80.55,
      date: DateTime.now().subtract(Duration(days: 5)),
    ),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addTransaction(String title, double amount, DateTime date) {
    final newTransaction = Transaction(
      title: title,
      amount: amount,
      id: DateTime.now().toString(),
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  void _showFormSheet(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(241, 243, 244, 1),
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Expenses App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add, color: Colors.deepPurple,),
            onPressed: () => _showFormSheet(context),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Chart(_recentTransactions),
          TransactionList(_transactions, _deleteTransaction),
        ],
      ),
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton.extended(
              backgroundColor: Colors.teal,
              label: Text('Add', style: TextStyle(fontWeight: FontWeight.bold)),
              icon: Icon(Icons.add),
              onPressed: () => _showFormSheet(context),
            ),
    );
  }
}
