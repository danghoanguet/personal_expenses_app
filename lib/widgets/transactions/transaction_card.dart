import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  final Function deleteTransaction;
  const TransactionCard(
      {Key? key, required this.transaction, required this.deleteTransaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: FittedBox(child: Text('\$${transaction.amount}')),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(DateFormat.yMMMd().format(transaction.date)),
        trailing: MediaQuery.of(context).size.width > 450
            ? TextButton.icon(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.red)),
                onPressed: () => deleteTransaction(transaction.id),
                label: Text('Delete'),
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              )
            : IconButton(
                onPressed: () => deleteTransaction(transaction.id),
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
      ),
    );
  }
}
