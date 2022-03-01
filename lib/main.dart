import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/chart_card.dart';
import 'package:flutter_complete_guide/text_field_card.dart';
import 'package:flutter_complete_guide/transaction.dart';
import 'package:flutter_complete_guide/transaction_card.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
        id: 't1', title: 'new shoes', amount: 69.99, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'new jacket', amount: 99.99, date: DateTime.now()),
    Transaction(
        id: 't3', title: 'new computer', amount: 2069.99, date: DateTime.now()),
    Transaction(
        id: 't4', title: 'new watch', amount: 169.99, date: DateTime.now()),
    Transaction(
        id: 't5', title: 'new shirt', amount: 49.99, date: DateTime.now()),
    Transaction(
        id: 't6', title: 'new food', amount: 39.99, date: DateTime.now()),
  ];

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ChartCard(),
        TextFieldCard(
            titleController: _titleController,
            amountController: _amountController),
        Column(
          children: transactions
              .map(
                (transaction) => TransactionCard(transaction: transaction),
              )
              .toList(),
        ),
      ],
    );
  }
}
