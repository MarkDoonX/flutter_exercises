/// This is a test about dartdoc comments!
/// [ListItem] is a Class that extends Stateless Widget
/// It is implemented in transactions_list.dart in ListView.builder() function

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

/// Refactored from Stateless Widget to Stateful Widget 
/// to be able to use initState()
/// which will permit me to test Keys by setting some random bgColors
class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required Transaction transaction,
    @required void Function(String id) deleteTransaction,
  }) : _transaction = transaction, _deleteTransaction = deleteTransaction, super(key: key);

  final Transaction _transaction;
  final void Function(String id) _deleteTransaction;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
 Color _bgColor;
  /// initState() runs before Build(), so we don't need to use setState()
  /// Here, i chose a random color when initState() is called
  @override
  void initState(){
    super.initState();
    print('initState() in _TransactionItemState');
    const availableColors = [
      Colors.blue,
      Colors.purple,
      Colors.red,
      Colors.pink,
      Colors.brown,
    ];

    _bgColor = availableColors[Random().nextInt(5)];
  }
  
  @override
  Widget build(BuildContext context) {
    print('build() in _TransactionItemState');
    /// This Card draws 1 item in the transactions_list
    return Card(
      elevation: 5,
      // ListTile widget fit particularly well to diplay the outcome of a looping though a list
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 40,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: FittedBox(
              child: Text(
                  // widget keyword permits to access this widget's properties in the current State
                  '\$${widget._transaction.amount.toStringAsFixed(2)}'),
            ),
          ),
        ),
        title: Text(
          // widget keyword permits to access this widget's properties in the current State
          widget._transaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMMd()
              .add_jm()
              // widget keyword permits to access this widget's properties in the current State
              .format(widget._transaction.date),
          style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: 15),
        ),
        /// trainling permits to add a widget ad the end of a card
        trailing: IconButton(
          // this widget is actually constant. a good practice is to anotate it as constant to avoid
          // that it's build method is called all the time.
          icon: const Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () =>
              // widget keyword permits to access this widget's properties in the current State
              widget._deleteTransaction(widget._transaction.id),
        ),
      ),
    );
  }
}
