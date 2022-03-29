# tf_filterable_list

A list having capabilities to filter the items for given filter. Supports listening to the filtered list.

## Supported Dart Versions

Dart SDK version ">=2.15.1 <3.0.0"

## Installation

Add the Package

```yaml
dependencies:
  tf_filterable_list:
    git:
      url: https://github.com/rahul-badgujar/tf_filterable_list_dart_package.git
      ref: main
```

## How to use

Import the package in your dart file

```dart
import 'package:tf_filterable_list/tf_filterable_list.dart';
```

### Creating and Initializing Instance

```dart
// Creating an instance of TfFilterableList.
// Provide template parameter T matching the data type of items the filterable list is going to store.
final instance = TfFilterableList<T>();
// MUST initialize the instance before using it.
instance.init();
```

### To listen to changes in filtered list

```dart
// Subscribe the stream to listen to the changes in filtered list.
instance.streamOfFilteredItems.listen((filteredListEvent) {
    print(filteredListEvent);
});
```

### Manipulating Items Lists

```dart
// ** To access different items lists **

// To access the list of all items in the list.
print(instance.allItems);
// To access the list of all items which satisfies the current filter applied.
print(instance.filteredItems);

// ** To add new items to all items list **

// List of items to add.
final newItemsToAdd=<T>[];  
// Add the items.
instance.addItems(newItemsToAdd);
// Call apply() to commit the changes and update filtered list.
// This also notifies the listeners listening to filtered list changes.
instance.apply();

// ** To clear all the items **
 
// Clear the all items list.
instance.clearAllItems();
// Call apply() to commit the changes and update filtered list.
// This also notifies the listeners listening to filtered list changes.
instance.apply();
```

### Manipulating the active filter

```dart
// Accessing the active filter
TfListItemFilter? filter=instance.activeFilter;

// ** Set/Update active filter **

// Provide new active filter
instance.setFilter((T item){
    // provide logic for filtering the item
    // If returned true => item has passed the filter
    // If returned false => item fails the filter
    return true;
});
// Call apply() to filtered the items with new filter provided above.
// Also, to notify listeners listening to the filtered list changes.
instance.apply();

// ** Clearing the active filter **

// Clear the active filter
instance.clearFilter();
// Call apply() to update filtered list for cleared filter.
// Clearing the filter makes filtered list same as all items
// Also, to notify listeners listening to the filtered list changes.
instance.apply();
```

### Disposing the Instance

```dart
// A good practice is to dispose the instance after use.
instance.dispose();
```

## Support for Useful Flutter Widgets

A Flutter Extension of this Dart Package [tf_filterable_list_flutter_extension package](https://github.com/rahul-badgujar/tf_filterable_list_dart_package.git) is designed to provide support of Useful Widgets you can use to pace up your UI Building.
