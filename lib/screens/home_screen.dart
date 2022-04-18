import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../widgets/chart/chart_card.dart';
import '../widgets/transactions/new_transaction.dart';
import '../widgets/transactions/transaction_list.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: 't1', title: 'new shoes', amount: 69.99, date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'new jacket',
        amount: 99.99,
        date: DateTime.now().subtract(Duration(days: 1))),
    Transaction(
        id: 't3',
        title: 'new computer',
        amount: 109.99,
        date: DateTime.now().subtract(Duration(days: 2))),
    Transaction(
        id: 't4',
        title: 'new watch',
        amount: 169.99,
        date: DateTime.now().subtract(Duration(days: 3))),
    Transaction(
        id: 't5',
        title: 'new shirt',
        amount: 49.99,
        date: DateTime.now().subtract(Duration(days: 4))),
    Transaction(
        id: 't6',
        title: 'new food',
        amount: 39.99,
        date: DateTime.now().subtract(Duration(days: 5))),
    Transaction(
        id: 't7',
        title: 'new drinks',
        amount: 79.99,
        date: DateTime.now().subtract(Duration(days: 6))),
  ];

  bool _showChart = false;

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
    final mediaQuery = MediaQuery.of(context);
    bool _inLandScape = mediaQuery.orientation == Orientation.landscape;
    return Platform.isIOS
        ? CupertinoPageScaffold(child: _buildBody(appBar(), _inLandScape))
        : Scaffold(
            appBar: appBar(),
            body: _buildBody(appBar(), _inLandScape),
            floatingActionButton: Platform.isIOS
                ? SizedBox()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context)),
          );
  }

  dynamic appBar() {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Personal Expenses',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
            title: Text(
              'Personal Expenses',
            ),
            actions: [
              IconButton(
                onPressed: () => _startAddNewTransaction(context),
                icon: Icon(Icons.add),
              ),
            ],
          );
  }

  Widget _buildBody(PreferredSizeWidget appBar, bool inLandScape) {
    return SafeArea(
      child: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:
            inLandScape ? _buildInLandScape(appBar) : _buildInPortrait(appBar),
      )),
    );
  }

  List<Widget> _buildInLandScape(PreferredSizeWidget appBar) {
    final mediaQuery = MediaQuery.of(context);
    return [
      Row(
        children: [
          Text("Show chart", style: Theme.of(context).textTheme.titleMedium),
          Switch.adaptive(
              activeColor: Theme.of(context).primaryColor,
              value: _showChart,
              onChanged: (val) {
                setState(() {
                  _showChart = val;
                });
              })
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      mediaQuery.padding.top -
                      appBar.preferredSize.height) *
                  0.7,
              child: ChartCard(recentTransactions: _recentTransactions))
          : Container(
              height: (mediaQuery.size.height -
                      mediaQuery.padding.top -
                      appBar.preferredSize.height) *
                  0.7,
              child: TransactionList(
                  userTransactions: _userTransactions,
                  deleteTransaction: _deleteTransaction),
            ),
    ];
  }

  List<Widget> _buildInPortrait(PreferredSizeWidget appBar) {
    final mediaQuery = MediaQuery.of(context);
    return [
      Container(
          height: (mediaQuery.size.height -
                  mediaQuery.padding.top -
                  appBar.preferredSize.height) *
              0.3,
          child: ChartCard(recentTransactions: _recentTransactions)),
      Container(
        height: (mediaQuery.size.height -
                mediaQuery.padding.top -
                appBar.preferredSize.height) *
            0.6,
        child: TransactionList(
            userTransactions: _userTransactions,
            deleteTransaction: _deleteTransaction),
      ),
      TextButton.icon(
        onPressed: (() {}),
        icon: Icon(
          Icons.add,
          size: 25,
        ),
        label: Text(
          'Add new transaction',
          style: TextStyle(fontSize: 20),
        ),
      )
    ];
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