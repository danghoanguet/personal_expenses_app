import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/transaction_card.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;

  const TransactionList({Key? key, required this.userTransactions})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: userTransactions
              .map(
                (transaction) => TransactionCard(transaction: transaction),
              )
              .toList(),
        ),
      ),
    );
  }
}
