import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/transaction.dart';
import 'package:flutter_complete_guide/widgets/transactions/new_transaction.dart';
import 'package:flutter_complete_guide/widgets/transactions/transaction_list.dart';
import 'widgets/chart/chart_card.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              //button: TextStyle(color: Colors.white)
            ),
        appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
            .copyWith(secondary: Colors.amber),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //     id: 't1', title: 'new shoes', amount: 69.99, date: DateTime.now()),
    // Transaction(
    //     id: 't2',
    //     title: 'new jacket',
    //     amount: 99.99,
    //     date: DateTime.now().subtract(Duration(days: 1))),
    // Transaction(
    //     id: 't3',
    //     title: 'new computer',
    //     amount: 2069.99,
    //     date: DateTime.now().subtract(Duration(days: 2))),
    // Transaction(
    //     id: 't4',
    //     title: 'new watch',
    //     amount: 169.99,
    //     date: DateTime.now().subtract(Duration(days: 3))),
    // Transaction(
    //     id: 't5', title: 'new shirt', amount: 49.99, date: DateTime.now()),
    // Transaction(
    //     id: 't6', title: 'new food', amount: 39.99, date: DateTime.now()),
  ];

  //Get a list of transaction which date is 7 day from DateTime.now()
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
        title: Text(
          'Personal Expenses',
        ),
        actions: [
          IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context)),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ChartCard(recentTransactions: _recentTransactions),
          TransactionList(
              userTransactions: _userTransactions,
              deleteTransaction: _deleteTransaction),
        ],
      ),
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  void _addNewTransaction(
      {required String title,
      required double amount,
      required DateTime chosenDate}) {
    final transaction = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: chosenDate);
    setState(() {
      _userTransactions.add(transaction);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return NewTransaction(
              onSubmit: (title, amount, chosenDate) => _addNewTransaction(
                  title: title, amount: amount, chosenDate: chosenDate));
        });
  }
}
