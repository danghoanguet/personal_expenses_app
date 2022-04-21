import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/transaction.dart' as ts;

class TransactionProvider with ChangeNotifier {
  List<ts.Transaction> _transactions = [];

  List<ts.Transaction> get transactions {
    return [..._transactions];
  }

  Future<void> addTransaction(ts.Transaction transaction) async {
    final user = FirebaseAuth.instance;
    final uid = user.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc('$uid')
        .collection('transactions')
        .add(transaction.toMap());
    notifyListeners();
  }

  Future<void> fetchUserTransactions() async {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user!.uid;

    final listTransaction = await FirebaseFirestore.instance
        .collection('users')
        .doc('$uid')
        .collection('transactions')
        .get();
    List<ts.Transaction> temp = [];
    listTransaction.docs.forEach((element) {
      temp.add(ts.Transaction.fromMap(element.data()));
    });
    _transactions = temp;
    //notifyListeners();
  }

  Future<void> deleteTransaction(String transactionId) async {
    final user = FirebaseAuth.instance;
    final uid = user.currentUser!.uid;

    var index =
        _transactions.indexWhere((element) => element.id == transactionId);
    var transaction = _transactions[index];

    _transactions.removeAt(index);
    var id = '';
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc('$uid')
          .collection('transactions')
          .get()
          .then((snapshot) {
        snapshot.docs.forEach((element) {
          if (element.data()['id'] == transactionId) id = element.id;
        });
        print(id);
      });
      await FirebaseFirestore.instance
          .doc('users/$uid/transactions/$id')
          .delete();
    } catch (e) {
      _transactions.insert(index, transaction);
      throw e;
    }

    notifyListeners();
  }

  //Get a list of transaction which date is 7 day from DateTime.now()
  List<ts.Transaction> get recentTransactions {
    return _transactions.where((transaction) {
      return transaction.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }
}
