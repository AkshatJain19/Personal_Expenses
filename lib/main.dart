import 'package:Personal_Expenses/widgets/chart.dart';
import 'package:Personal_Expenses/widgets/transactions_list.dart';

import './widgets/new_Transactions.dart';
import './models/transactioan.dart';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expense',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold),
            button: TextStyle(color: Colors.white)),
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold))),
      ),
      home: MyHomePage(),
    );
  }
}

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String tittleinput;

  String amountinput;

  final List<Transactions> _userTranction = [
    //Transactions(
    //id: 'i1', name: 'shoes', amount: 2000.99, date: DateTime.now()),
    // Transactions(id: 'i2', name: 'sabji', amount: 150, date: DateTime.now())
  ];
  void _addTransactions(
      String txTittle, double txAmount, DateTime choosendate) {
    final txTRA = Transactions(
        id: DateTime.now().toString(),
        name: txTittle,
        amount: txAmount,
        date: choosendate);
    setState(() {
      _userTranction.add(txTRA);
    });
  }

  void deleteTransaction(String id) {
    setState(() {
      _userTranction.removeWhere((element) => element.id == id);
    });
  }

  List<Transactions> get _recentTransactions {
    return _userTranction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _startaddnewtransaction(
    BuildContext ctx,
  ) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_addTransactions);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startaddnewtransaction(context),
      ),
      appBar: AppBar(
        title: Text('Personal Expence'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startaddnewtransaction(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Chart(_recentTransactions),
          TransactionList(_userTranction, deleteTransaction)
        ]),
      ),
    );
  }
}
