import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function newTX;

  NewTransaction(this.newTX);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final tittlecontroller = TextEditingController();

  final amountcontroller = TextEditingController();
  DateTime selecteddate;

  void submmited() {
    if (amountcontroller.text.isEmpty) {
      return;
    }
    final submittedText = tittlecontroller.text;
    final submittedAmount = double.parse(amountcontroller.text);
    if (submittedText.isEmpty || submittedAmount <= 0 || selecteddate == null) {
      return;
    }
    widget.newTX(submittedText, submittedAmount, selecteddate);
    Navigator.of(context).pop();
  }

  void presentDatepicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        selecteddate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Tittle'),
              controller: tittlecontroller,
              onSubmitted: (value) => submmited(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'amount'),
              controller: amountcontroller,
              keyboardType: TextInputType.number,
              onSubmitted: (value) => submmited(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(selecteddate == null
                        ? 'No Date Chosen'
                        : 'Picked Date ${DateFormat.yMd().format(selecteddate)}'),
                  ),
                  FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: presentDatepicker,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
            RaisedButton(
              onPressed: submmited,
              child: Text('Add a Transaction'),
              textColor: Theme.of(context).textTheme.button.color,
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
