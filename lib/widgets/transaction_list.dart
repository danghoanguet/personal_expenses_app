import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/transaction_card.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function deleteTransaction;

  const TransactionList(
      {Key? key,
      required this.userTransactions,
      required this.deleteTransaction})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return userTransactions.isEmpty
        ? Column(
            children: [
              Spacer(),
              Text(
                'No transactions added yet',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Spacer(),
              Container(
                height: 200,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return TransactionCard(
                transaction: userTransactions[index],
                deleteTransaction: deleteTransaction,
              );
            },
            itemCount: userTransactions.length,
          );
  }
}
