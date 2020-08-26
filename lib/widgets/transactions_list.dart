import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transactioan.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> transactions;
  Function deletefxn;
  TransactionList(this.transactions, this.deletefxn);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 455,
      child: transactions.isEmpty
          ? Center(
              child: Column(
                children: <Widget>[
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Container(
                    height: 250,
                    child: Image.asset(
                      'assests/image/empty-state-2130362-1800926.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                            child: Text('₹ ${transactions[index].amount}')),
                      ),
                    ),
                    title: Text(
                      transactions[index].name,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => deletefxn(transactions[index].id),
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
