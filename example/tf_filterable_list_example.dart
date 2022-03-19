import 'dart:async';
import 'dart:math';

import 'package:tf_filterable_list/tf_filterable_list.dart';

void main() {
  // Creating an instance of Filterable List.
  final numbersList = TfFilterableList<int>();
  // Must initialize the instance.
  numbersList.init();
  // Add numbers 1-100 to the list
  numbersList.addItems(List<int>.generate(100, (index) => index + 1));
  // Listen to changes in filtered list
  numbersList.streamOfFilteredItems.listen((filteredNumbersList) {
    print(filteredNumbersList);
  });
  // --- FOR DEMO ---
  // Each 2 second, we filter the whole list.
  // The list is filtered to show numbers which are divisible by K.
  // K here is a random number generate between 1-10 in each turn of filtering.
  Timer.periodic(Duration(seconds: 2), (timer) {
    // generating K, a random number between range 1 to 10
    final k = Random().nextInt(10) + 1;
    print('Filtering the list for K=$k as divisor:');
    // set filter
    numbersList.setFilter((item) => item % k == 0);
    // apply and make changes reflect for filtered items
    // calling apply() is esssential step whenever we are
    // changing something and expect filtered list to update.
    numbersList.apply();
  });
}
