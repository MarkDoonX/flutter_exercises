/// See _addnNewTransaction to have example of comments


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/transactions_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() {
// With commented part below, we prevent the app from being seen in landscape mode and only allow portrait mode
// we do this for apps that really dont make sense to be seen in landscape mode, or if we are too lazy to
// make the app render good on landscape mode

  // SystemChrome.setPreferredOrientations(
  //   [
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //     DeviceOrientation.landscapeLeft,
  //     DeviceOrientation.landscapeRight,
  //   ],
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build() MyApp Stateless');
    return MaterialApp(
      title: 'Flutter App',
      // the Theme permits to store colors in some properties and use it everywhere we want
      // primarySwatch permits to unlock shades of the defined color.
      // => using: Theme.of(context).primaryColor
      // or derived shades of the color:
      // =>  heme.of(context).primaryColorLight for example
      theme: ThemeData(
        // to use primarySwatch when primarycolor is set, use promaryColorDark or primaryColorLight
        primarySwatch: Colors.blueGrey,
        accentColor: Colors.amberAccent[100],
        // primaryColor: Colors.black,
        cardColor: Colors.white,
        errorColor: Colors.red,

        // importing font from pubspec.yaml, which links with fonts in assets/fonts
        // fontFamily is the default font for the whole app
        // fontFamily: 'OpenSans',

        // Below, we are setting a font and size for AppBar's title (text that is markedd as title)
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  // using the bold version of our own font
                  fontWeight: FontWeight.bold,
                  // color: Colors.black,
                ),
              ),
        ),
        // Below, giving a theme for all the titles in the app.
        //
        textTheme: TextTheme(
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            button: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

/// "with" keyword permits to access properties/methods from an other class than the one we already extend 
/// indeed, we can only extend from 1 class, that's why we have to use "with" in that case
/// WidgetsBindingObserver class permits to access observers that check if the LifeCycleSate 
/// of the widget changes for example.  
class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver{
  
  final List<Transaction> _transactionsList = [
    Transaction(
      id: 't1',
      title: 'Shoes',
      amount: 50,
      date: DateTime(2019, 9, 18),
    ),
    Transaction(
      id: 't2',
      title: 'Grocery',
      amount: 100,
      date: DateTime(2019, 9, 17),
    ),
    Transaction(
      id: 't3',
      title: 'Darts',
      amount: 200,
      date: DateTime(2019, 9, 16),
    ),
    Transaction(
      id: 't4',
      title: 'Flowers',
      amount: 50,
      date: DateTime(2019, 9, 15),
    ),
    Transaction(
      id: 't5',
      title: 'Shirt',
      amount: 50,
      date: DateTime(2019, 9, 14),
    ),
    Transaction(
      id: 't6',
      title: 'Flowers',
      amount: 50,
      date: DateTime(2019, 9, 13),
    ),
    Transaction(
      id: 't7',
      title: 'Flowers',
      amount: 50,
      date: DateTime(2019, 9, 12),
    ),
  ];

  bool _isChartDisplayed = false;

  /// LIFE CYCLE OBSERVERS!
  /// 
  /// Life Cycle is the State of our entire App!
  /// Life Cycle State can be modified by factors external to the app
  /// for example, if we click on the home button on the phone, the application 
  /// will not be active anymore: it will be paused.
  /// then if you go back to it, it would resume
  /// inactice, paused, resumed and dsuspended are 4 states the app can take.
  /// 
  /// Using Lyfe Cycle can be useful to:
  /// - refetch data when it's coming back into foreground
  /// - clear listeners when the app is getting paused 
  
  /// we override initSate() to add an observer to this class
  /// when initState() is called
  @override
  void initState() { 
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  /// method that permits to do something when Life Cycle changes
  /// it needs to instanciate an observer to work
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  /// method that permits to remove the observer when dispose is called
  /// if we do not remove the observer, it will keep use memory even if
  /// the widget is not used anymore
  @override
  void dispose() { 
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }


  // returns a list where Transactions are not older than 7 days
  List<Transaction> get recentTransactionsList {
    return _transactionsList.where((tx) {
      DateTime oneWeekAgo = DateTime.now().subtract(Duration(days: 7));
      if (tx.date.compareTo(oneWeekAgo) >= 0) return true;
      return false;
    }).toList();
  }
  /// Creates a new Transaction Object
  void _addNewTransaction({String txTitle, double txAmount, DateTime txDate}) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: txDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _transactionsList.add(newTx);
    });
    print("Print from _addNewTransaction in main.dart ${DateTime.now()}");
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactionsList.removeWhere((tx) => tx.id == id);
    });
  }

  /// Shows the NewTransaction Widget: it appears from the bottom of the page
  ///
  /// We don't need to place NewTransaction Widget in the Widgets tree anymore
  /// We differenctiate contextes ctx an bCtx. ctx is global context, bCtx is builder's context
  void _startAddNexTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      /// bCtx is not used an dautomatically filledd by Flutter. We could put a "_" instead.
      builder: (bCtx) {
        /// We wrap NewTransaction into a GestureDetector widget which permits to contraoll what happens on
        /// NewTransaction Widget when we tap on it for exemple.
        /// - Here we put a blank function to onTap to avoid that the NewTransacion Widget reloads when we tap on it
        /// - behavior: HitTestBehavior.opaque permits to make the NewTransaction widget opaque, which prevents
        ///   that a click on it would actually also make a click on the sheet below, which would reload the
        ///   NewTransaction Widget as well.
        ///
        /// Still we have a problem: when we fill the title then the amount, the Widget reloads...
        /// for this we need to change NewTransaction Widget from a Stateless to a Statefull Widget.
        return GestureDetector(
          child: NewTransaction(_addNewTransaction),
          onTap: () {},
          behavior: HitTestBehavior.opaque,

        );
      },
    );
  }

  // TESTING to see DateTime
  void _printDateTime() {
    for (int i = 0; i < _transactionsList.length; i++) {
      print("${_transactionsList[i].title}: ${_transactionsList[i].date}");
    }
  }

  @override
  Widget build(BuildContext context) {
    print('build() MyHomePage Stateful');
    // We store the MediaQuery.of(context) in a variable to avoid to have to create a new instance of
    // the MediaQuery object every time we call for it, whiich is better for perfomance
    final mediaQuery = MediaQuery.of(context);

  
    final _isLandscapeMode =
        mediaQuery.orientation == Orientation.landscape;
    // We create an appBar variable that holds the appBar widget because then we can access
    // some of its properties such as the height of the AppBar, which is useful for responsive design
    // Also this variable must be defined in this widget to access the context and variables/functions
    final appBar = AppBar(
      backgroundColor: Theme.of(context).primaryColorDark,
      title: Text(
        'Flutter App',
        textAlign: TextAlign.center,
      ),
      // actions is where we can put buttons in appBar
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNexTransaction(context),
        ),
        // TESTING
        IconButton(
          icon: Icon(Icons.assessment),
          onPressed: () {
            _printDateTime();
            for (int i = 0; i < recentTransactionsList.length; i++) {
              print(
                  "recentTransactionsList: ${recentTransactionsList[i].date}");
            }
          },
        )
      ],
    );

    final Widget showChart = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Show Chart'),
        Switch(
          value: _isChartDisplayed,
          // val here reflects if the switch is toogled or not. this is a boolean
          // this pattern is the defult way to use a Switch Widget
          onChanged: (val) {
            setState(() {
              _isChartDisplayed = val;
            });
          },
        ),
      ],
    );

    final chartLandscape = Container(
      // we substract the total height of the screen by the height of the appBar, and apply a factor
      // to share the space as we want
      // we also deduct th height of the system status bar on top, chich we access with .padding.top
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.6,
      child: Chart(recentTransactionsList),
    );

    final Widget chartPortrait = Container(
      // we substract the total height of the screen by the height of the appBar, and apply a factor
      // to share the space as we want
      // we also deduct th height of the system status bar on top, chich we access with .padding.top
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.3,
      child: Chart(recentTransactionsList),
    );

    final Widget txList = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionsList(_transactionsList, _deleteTransaction),
    );

    // This is a "Builder Method": a method that permits to build widget(s)
    List<Widget> _portraitRenderedWidget() {
      return [chartPortrait, txList,];
    }

    // An other Builder Method
    List<Widget> _landscapeRenderedWidget() {
      // below, we are doing an if in an if: the synthaxe is confusing
      return [showChart, _isChartDisplayed ? chartLandscape : txList,];
    }



    return Scaffold(
      appBar: appBar,
      // the SingleChildScrollView permits to make the body scrollable and to avoid conflict when writing panel pops up
      body: SingleChildScrollView(
        child: Container(
          // color: Colors.black,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // - here we are conditionnally displaying widgets depending on if the Device is on landscape mode
              //   or not
              // - to make i better organised and readable, we are creating a builder method which will return Widget(s)
              //   in our case it returns a List<Widget> since we are i a Column and have multiple widgets tu render
              // - the three dots (...) permits to extract each element of the List<Widget> to give the Column Widget
              //   individual widgets and not a Lsit<Widget>
              if (_isLandscapeMode) ..._landscapeRenderedWidget(),
              if (!_isLandscapeMode) ..._portraitRenderedWidget(),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        // backgroundColor: Theme.of(context).primaryColorDark,
        child: Icon(Icons.add),
        onPressed: () => _startAddNexTransaction(context),
      ),
    );
  }
}
