import 'package:intl/intl.dart';
import 'chart_bar.dart';
import '../models/transactioan.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  final List<Transactions> resentTransaction;
  Chart(this.resentTransaction);
  List<Map<String, Object>> get groupedTransactionValue {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: 6 - index));
      var totalSum = 0.0;
      for (var i = 0; i < resentTransaction.length; i++) {
        if (resentTransaction[i].date.day == weekday.day &&
            resentTransaction[i].date.month == weekday.month &&
            resentTransaction[i].date.year == weekday.year) {
          totalSum += resentTransaction[i].amount;
        }
      }
      return {'day': DateFormat.E().format(weekday), 'amount': totalSum};
    });
  }

  double get totalSpending {
    return groupedTransactionValue.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValue.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    data['day'],
                    data['amount'],
                    totalSpending == 0
                        ? 0.0
                        : (data['amount'] as double) / totalSpending),
              );
            }).toList()),
      ),
    );
  }
}
