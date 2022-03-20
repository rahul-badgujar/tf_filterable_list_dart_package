import 'package:tf_data_streamer/tf_data_streamer.dart';

/// Used to provide a items filter for list.
typedef TfListItemFilter<T> = bool Function(T item);

///
/// TfFilterableList
///
/// A list having capabilities to filter the items for given filter. \
/// Supports listening to the filtered list.
///
class TfFilterableList<T> extends TfDataStreamer<List<T>> {
  // List of all items.
  final List<T> _allItems = [];
  // List of filtered items.
  List<T> _filteredItems = [];

  // Currently active filter to filter out items.
  TfListItemFilter<T>? _activeFilter;

  /// Get list of all the items considered for filtering.
  List<T> get allItems {
    return _allItems;
  }

  /// Get list of all the items which pass the current filter.
  ///
  /// NOTE: If no current filter exists, this list is equivalent to allItems list.
  List<T> get filteredItems {
    return _filteredItems;
  }

  /// Add more items to `allItems` list.
  ///
  /// This method should be followed by a call to `apply()`
  /// to apply current filter on newly added items and notify the listeners.
  void addItems(List<T> newItemsList) {
    _allItems.addAll(newItemsList);
  }

  /// Clears the list of all items. Also resulting in clearing of the filtered list as well.
  ///
  /// This method should be followed by a call to `apply()`
  /// to notify the listeners about clearing of items.
  void clearAllItems() {
    _allItems.clear();
  }

  /// Returns current active filter if exists, otherwise return null.
  TfListItemFilter<T>? get activeFilter {
    return _activeFilter;
  }

  /// Set a new filter for filtering all the items.
  ///
  /// If you wish that list should be filtered with this new filter,
  /// this method call should be followed by `apply()` to apply the filter and notify listeners.
  void setFilter(TfListItemFilter filter) {
    _activeFilter = filter;
  }

  /// Clears the current active filter.
  ///
  /// If you wish that clearing of filter should reflect filtered list,
  /// then this method call should be followed by `apply()` to update the
  /// filtered list and notify listeners.
  void clearFilter() {
    _activeFilter = null;
  }

  /// Apply all the changes and refresh the filtered list.
  /// Also, notify the listeners about changes in filtered list.
  ///
  /// Here, the changes can be any kind of change which may result in change of filtered list contents.
  /// Like, change in active filter, addition of new items to all items list, clearing of all items list.
  void apply() {
    _filteredItems = _filterItemsFollowingFilter(
        itemsList: _allItems, filter: _activeFilter);
    _notifyFilteredItemsListChanges();
  }

  /// Notifies listeners about changes in filtered list.
  void _notifyFilteredItemsListChanges() {
    addData(_filteredItems);
  }

  /// Utility method to apply given [filter] to [itemsList]
  /// and return the list of items which follow given [filter].
  ///
  /// NOTE: if filter is null, the returned filtered list will match the [itemsList] provided.
  List<T> _filterItemsFollowingFilter(
      {required List<T> itemsList, TfListItemFilter<T>? filter}) {
    final filterOutputList = <T>[];
    for (final item in itemsList) {
      bool satisfiesFilter = true;
      if (filter != null) {
        satisfiesFilter = filter.call(item) == true;
      }
      if (satisfiesFilter) {
        filterOutputList.add(item);
      }
    }
    return filterOutputList;
  }

  /// Stream streaming the filtered items list upon changes.
  Stream<List<T>> get streamOfFilteredItems {
    return stream;
  }

  @Deprecated('Do nothing method.')
  @override
  void reload() {}
}
