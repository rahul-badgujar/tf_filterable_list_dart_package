# tf_filterable_list

A list having capabilities to filter the items for given filter. Supports listening to the filtered list.

## Supported Dart Versions

**Dart SDK version ">=2.15.1 <3.0.0"**

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
// Provide template parameter T matching the data type 
// of items the filterable list is going to store.
final instance = TfFilterableList<T>();
// MUST initialize the instance before using it.
instance.init();
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
instance.clearAllItema();
// Call apply() to commit the changes and update filtered list.
// This also notifies the listeners listening to filtered list changes.
instance.apply();
```

### Manipulating the active filter

```dart
// ** Accessing the active filter **

// Get access to active filter
TfListItemFilter filter=instance.activeFilter;


```

### Disposing the Instance

```dart
// A good practice is to dispose the instance after use.
instance.dispose();
```
