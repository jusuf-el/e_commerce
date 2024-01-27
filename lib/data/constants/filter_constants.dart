import 'package:e_commerce/data/models/sort.dart';

class FilterConstants {
  static final List<Sort> priceSorting = [
    Sort(title: 'Highest price', value: 'asc'),
    Sort(title: 'Lowest price', value: 'desc'),
  ];

  static const List<int> resultNumbers = [10, 20, 30, 50];
}
