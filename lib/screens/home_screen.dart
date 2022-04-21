import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/transaction_provider.dart';

import '../models/transaction.dart';
import '../widgets/chart/chart_card.dart';
import '../widgets/transactions/new_transaction.dart';
import '../widgets/transactions/transaction_list.dart';

class MyHomePage extends StatefulWidget {
  final TransactionProvider transactionProvider;

  const MyHomePage({Key? key, required this.transactionProvider})
      : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    print('build run');
    final mediaQuery = MediaQuery.of(context);
    bool _inLandScape = mediaQuery.orientation == Orientation.landscape;
    return FutureBuilder(
      future: widget.transactionProvider.fetchUserTransactions(),
      builder: (context, snapshot) => (snapshot.connectionState ==
              ConnectionState.waiting)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Platform.isIOS
              ? CupertinoPageScaffold(
                  navigationBar: appBar(),
                  child: _buildBody(appBar(), _inLandScape))
              : Scaffold(
                  appBar: appBar(),
                  body: _buildBody(appBar(), _inLandScape),
                  floatingActionButton: Platform.isIOS
                      ? SizedBox()
                      : FloatingActionButton(
                          child: Icon(Icons.add),
                          onPressed: () => _startAddNewTransaction(context)),
                ),
    );
  }

  dynamic appBar() {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            backgroundColor: Theme.of(context).primaryColor,
            middle: FittedBox(
              child: Text(
                'Personal Expenses',
                style: TextStyle(color: Colors.white),
                //softWrap: false,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(
                    CupertinoIcons.add,
                    color: Colors.white,
                  ),
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
              child: ChartCard(
                  recentTransactions:
                      widget.transactionProvider.recentTransactions))
          : Container(
              height: (mediaQuery.size.height -
                      mediaQuery.padding.top -
                      appBar.preferredSize.height) *
                  0.7,
              child: TransactionList(
                  userTransactions: widget.transactionProvider.transactions,
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
          child: ChartCard(
              recentTransactions:
                  widget.transactionProvider.recentTransactions)),
      Container(
        height: (mediaQuery.size.height -
                mediaQuery.padding.top -
                appBar.preferredSize.height) *
            0.6,
        child: TransactionList(
            userTransactions: widget.transactionProvider.transactions,
            deleteTransaction: _deleteTransaction),
      ),
    ];
  }

  void _deleteTransaction(String id) {
    widget.transactionProvider.deleteTransaction(id);
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
    widget.transactionProvider.addTransaction(transaction);
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
