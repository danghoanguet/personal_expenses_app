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
      // by defalut ListView takes infiniti height which will cause
      //an error because above this ListView is a Column which will
      //take all the height it children need
      //, in this case it's parent has 300 height which
      //is the Container so there no error
      // child: ListView(
      //   children: userTransactions
      //       .map(
      //         (transaction) => TransactionCard(transaction: transaction),
      //       )
      //       .toList(),
      // ),
      child: userTransactions.isEmpty
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
                return TransactionCard(transaction: userTransactions[index]);
              },
              itemCount: userTransactions.length,
            ),
    );
  }
}
