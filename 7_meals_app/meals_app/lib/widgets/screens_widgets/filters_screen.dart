import 'package:flutter/material.dart';

import '../non_screens_widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  FiltersScreen({@required this.saveFilters, @required this.currentFilters});

  static const String selfRoute = "/filters";
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree;
  bool _vegetarian;
  bool _vegan;
  bool _lactoseFree;

  @override
  initState() {
    _glutenFree = widget.currentFilters['gluten-free'];
    _vegetarian = widget.currentFilters['vegetarian'];
    _vegan = widget.currentFilters['vegan'];
    _lactoseFree = widget.currentFilters['lactose-free'];
    super.initState();
  }

  Widget _buildSwitchListTile(
      {@required String title,
      @required String subtitle,
      @required bool valueRef,
      Function updateValue}) {
    return Expanded(
      child: ListView(
        children: <Widget>[
          SwitchListTile(
            title: Text(title),
            value: valueRef,
            subtitle: Text(subtitle),
            onChanged: updateValue,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final Map<String, bool> _selectedFilters = {
                'gluten-free': _glutenFree,
                'vegetarian': _vegetarian,
                'vegan': _vegan,
                'lactose-free': _lactoseFree,
              };
              widget.saveFilters(_selectedFilters);
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          // Expanded takes all remaining  space in a Row, Column or Flex
          _buildSwitchListTile(
              title: 'Gluten-free',
              subtitle: 'Only include gluten-free meals',
              valueRef: _glutenFree,
              updateValue: (newValue) {
                setState(() {
                  _glutenFree = newValue;
                });
                print(_glutenFree);
              }),
          _buildSwitchListTile(
              title: 'Vegetarian',
              subtitle: 'Only include vegetarian meals',
              valueRef: _vegetarian,
              updateValue: (newValue) {
                setState(() {
                  _vegetarian = newValue;
                });
                print(_vegetarian);
              }),
          _buildSwitchListTile(
              title: 'Vegan',
              subtitle: 'Only include Vegan meals',
              valueRef: _vegan,
              updateValue: (newValue) {
                setState(() {
                  _vegan = newValue;
                });
                print(_vegan);
              }),
          _buildSwitchListTile(
              title: 'Lactose-free',
              subtitle: 'Only include lactose-free meals',
              valueRef: _lactoseFree,
              updateValue: (newValue) {
                setState(() {
                  _lactoseFree = newValue;
                });
                print(_lactoseFree);
              }),
        ],
      ),
    );
  }
}
