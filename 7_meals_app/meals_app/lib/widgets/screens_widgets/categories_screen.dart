/// Notable features in this file:
///
/// - [GridView()] Widget:
///    -> [gridDelegate]: [SliverGridDelegateWithMaxCrossAxisExtent()]

import 'package:flutter/material.dart';

import '../../dummy_data.dart';
import '../non_screens_widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        padding: EdgeInsets.all(15),
        children: dummyCategories.map((catData) {
          return CategoryItem(
            title: catData.title,
            color: catData.color,
            id: catData.id,
          );
        }).toList(),

        // gridDelegate is required
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
      ),
    );
  }
}
