import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class NewTransaction extends StatefulWidget {
  final void Function({String txTitle, double txAmount, DateTime txDate})
      _addNewTransaction;

  // testing when constructor is called
  NewTransaction(this._addNewTransaction) {
    print('Constructor in NewTransaction Widget');
  }

  @override
  _NewTransactionState createState() {
    print('CreateState in NewTransaction Widget ');    
    return _NewTransactionState();
  } 
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _pickedDate;
  static Random _random = Random();
  Color _randomColor = Colors.blueGrey;
  double _padding = 10;
  // final _padding = _random.nextInt(100).toDouble();

  _NewTransactionState(){
    print('Constructor in NewTransaction State');
  }

  // Below overriden functions come from Sate classe we herit from
  // Testing when they are called
  // initSate(), didUpdateWidget() and dispose() are Life Cycle methods always called in stateful widgets
  // we have to call super. to be sure that the parent function runs, and not only ours
  @override
  void initState() {
    super.initState();
    print('initState()');
  }  

  // oldwidget is the previous widget that was attached to the state
  @override
  void didUpdateWidget(NewTransaction oldWidget) { 
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget()');    
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose()');
  }

  bool _isNumeric(String str) {
    if (str == null) return false;
    if (double.tryParse(str) != null) return true;
    return false;
  }

  void _submitData() {
    final String title = _titleController.text;
    final String amount = _amountController.text;

    if (_pickedDate == null) return;
    if (title.isEmpty) return;
    if (amount.isEmpty)
      return;
    else if (!_isNumeric(amount))
      return;
    else if (double.parse(amount) <= 0) return;

    // the widget property permits to use a function that is defined in the parent widget class,
    // ito the correspoonding State class
    widget._addNewTransaction(
      txTitle: _titleController.text,
      txAmount: double.parse(_amountController.text),
      txDate: _pickedDate,
    );

    // In this case, Navigator permits to close the topmost screen (here this will be NewTransaction Widget)
    Navigator.of(context).pop();
  }

  void randomOutput() {
    setState(() {
      _randomColor = Color.fromRGBO(
        _random.nextInt(250),
        _random.nextInt(250),
        _random.nextInt(250),
        1,
      );
      _padding = 20 + _random.nextInt(40).toDouble();
    });
  }

  void _presentDatePicker() {
    // showDatePicker returns a Future. That's why we can use a .then() on it
    // it returns a Future because we dont know when the user will chose a date then click 'ok'
    // the function we put in then((){}) will execute only when we click on 'ok' to validate a date
    // .then() doesn't block the execution of the code after showDatePicker: here, the print() will occur
    // before what's in the then
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;

      setState(() {
        _pickedDate = pickedDate;
      });
    });

    print('...');
  }

  @override
  Widget build(BuildContext context) {
    // print('build() new_transaction Stateful');
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Scaffold(
          body: SingleChildScrollView(
            child: AnimatedContainer(
              padding: EdgeInsets.all(_padding),
              // using a _random color
              color: _randomColor,
              duration: Duration(seconds: 1),
              child: Card(
                color: Theme.of(context).accentColor,
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      // Fires after every Key Stroke. here, value automatically takes the value of the input
                      // onChanged: (value) => titleInput = value,
                      // OR
                      controller: _titleController,
                      decoration: InputDecoration(labelText: 'Title'),
                      // onSubmited needs a function that takes a string in params... but we dont use it.
                      // "_" permits to say that we have a param here, but that we dont use it
                      onSubmitted: (_) => _submitData(),
                    ),
                    TextField(
                      // amount value should be an int, but any input is Auto converted to String
                      // onChanged: (value) => amountInput = value,
                      // OR
                      controller: _amountController,
                      decoration: InputDecoration(labelText: 'Amount'),
                      // keyboardType number permits to diplay number panel when clicking on amount field
                      keyboardType: TextInputType.number,
                      onSubmitted: (_) => _submitData(),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      // to make the widgets space betwee, can also use the Expanded widget to wrap Row()
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(_pickedDate == null
                              ? 'Date not chosen!'
                              : 'Picked date: ${DateFormat.yMMMd().format(_pickedDate)}'),
                          RaisedButton(
                            color: Theme.of(context).primaryColorDark,
                            textColor: Theme.of(context).textTheme.button.color,
                            child: Text('chose date'),
                            onPressed: _presentDatePicker,
                          ),
                        ],
                      ),
                    ),
                    RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).textTheme.button.color,
                      child: Text(
                        'Add Transaction',
                      ),
                      onPressed: _submitData,
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColorDark,
            child: Icon(
              Icons.access_alarm,
              color: Theme.of(context).textTheme.button.color,
            ),
            onPressed: () => randomOutput(),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }
}
