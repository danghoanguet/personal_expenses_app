import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/transaction.dart';
import 'package:flutter_complete_guide/widgets/new_transaction.dart';
import 'package:flutter_complete_guide/widgets/transaction_list.dart';

class UserTransactions extends StatefulWidget {
  UserTransactions({Key? key}) : super(key: key);

  @override
  State<UserTransactions> createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
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
    // Transaction(
    //     id: 't6', title: 'new food', amount: 39.99, date: DateTime.now()),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(
          onSubmit: (title, amount) =>
              _addNewTransaction(title: title, amount: amount),
        ),
        // NewTransaction(onSubmit: _addNewTransaction),
        TransactionList(userTransactions: _userTransactions),
      ],
    );
  }

  void _addNewTransaction({required String title, required double amount}) {
    final transaction = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: DateTime.now());
    setState(() {
      _userTransactions.add(transaction);
    });
  }
}
