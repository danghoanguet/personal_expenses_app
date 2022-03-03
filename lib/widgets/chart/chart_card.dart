import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/transaction.dart';
import 'package:flutter_complete_guide/widgets/chart/chart_bar.dart';
import 'package:intl/intl.dart';

class ChartCard extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const ChartCard({Key? key, required this.recentTransactions})
      : super(key: key);

  List<Map<String, Object>> get groupTransactionValues {
    return List.generate(7, (index) {
      // weekDay se tru di 7 ngay ke tu DateTime.now() de lay dc cac ngay trong 1 tuan truoc do
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      // sum all the amount in weekDay which is same Date as each recentTransactions
      double totalAmountADay = 0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year)
          totalAmountADay += recentTransactions[i].amount;
      }

      // we will return a list of map has day
      //and the total amount spent that day
      return {'day': DateFormat.E().format(weekDay), 'amount': totalAmountADay};
    }).reversed.toList();
  }

  double get totalAmountAWeek {
    return groupTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      // this card take it's child size
      // color: Colors.blue,
      elevation: 6,
      margin: EdgeInsets.all(
        20,
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupTransactionValues.map((index) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  label: index['day'] as String,
                  spendingAmount: index['amount'] as double,
                  spendingPctOfTotal: totalAmountAWeek == 0.0
                      ? 0.0
                      : (index['amount'] as double) / totalAmountAWeek),
            );
          }).toList(),
        ), // this text size depends on its String we give so to set size we need container wraped around it
      ),
    );
  }
}
