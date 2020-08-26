import 'package:flutter/material.dart';

class Transactions {
  String id;
  String name;
  double amount;
  DateTime date;

  Transactions(
      {@required this.id,
      @required this.name,
      @required this.amount,
      @required this.date});
}
