import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/transactions/transaction_card.dart';
import '../../models/transaction.dart';

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
    return Container(
      // by defalut ListView takes infiniti height which will cause
      // an error because above this ListView is a Column which will
      // take all the height it children need
      // , in this case it's parent has 300 height which
      // is the Container so there no error
      // child: ListView(
      //   children: userTransactions
      //       .map(
      //         (transaction) => TransactionCard(transaction: transaction, deleteTransaction: deleteTransaction),
      //       )
      //       .toList(),
      // ),
      child: userTransactions.isEmpty
          ? LayoutBuilder(builder: (context, constraints) {
              return Column(
                children: [
                  Spacer(),
                  Text(
                    'No transactions added yet',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Spacer(),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            })
          : ListView(
              children: userTransactions
                  .map(
                    (transaction) => TransactionCard(
                        key: ValueKey(transaction.id),
                        transaction: transaction,
                        deleteTransaction: deleteTransaction),
                  )
                  .toList(),
            ),
      // : ListView.builder(
      //
      //     itemBuilder: (context, index) {
      //       //return TransactionCard(transaction: userTransactions[index]);
      //       return TransactionCard(
      //key: key,
      //           transaction: userTransactions[index],
      //           deleteTransaction: deleteTransaction);
      //     },
      //     itemCount: userTransactions.length,
      //   ),
    );
  }
}
