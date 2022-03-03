import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/transactions/transaction_card.dart';
import '../../models/transaction.dart';
import 'package:intl/intl.dart';

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
      height: 400,
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
                //return TransactionCard(transaction: userTransactions[index]);
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: FittedBox(
                            child: Text('\$${userTransactions[index].amount}')),
                      ),
                    ),
                    title: Text(
                      userTransactions[index].title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(DateFormat.yMMMd()
                        .format(userTransactions[index].date)),
                    trailing: IconButton(
                        onPressed: () =>
                            deleteTransaction(userTransactions[index].id),
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  ),
                );
              },
              itemCount: userTransactions.length,
            ),
    );
  }
}
