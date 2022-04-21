import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_complete_guide/providers/transaction_provider.dart';
import 'package:flutter_complete_guide/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'auth_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // TODO: Implement stream
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          return ChangeNotifierProvider(
            create: (context) => TransactionProvider(),
            child: Consumer<TransactionProvider>(
              builder: (context, transactionProvider, child) => MyHomePage(
                transactionProvider: transactionProvider,
              ),
            ),
          );
        }
        return AuthScreen();
      },
    );
  }
}
