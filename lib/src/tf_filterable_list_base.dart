import 'package:tf_data_streamer/tf_data_streamer.dart';

typedef TfListItemFilter<T> = bool Function(T item);

class TfFilterableList<T> extends TfDataStreamer<List<T>> {
  final List<T> _allItems = [];
  List<T> _filteredItems = [];

  TfListItemFilter<T>? _currentFilter;

  List<T> get allItems {
    return _allItems;
  }

  List<T> get filteredItems {
    return _filteredItems;
  }

  void addItems(List<T> newItemsList) {
    _allItems.addAll(newItemsList);
  }

  void clearAllItems() {
    _allItems.clear();
  }

  void setFilter(TfListItemFilter filter) {
    _currentFilter = filter;
  }

  void apply() {
    _filteredItems = _filterItemsFollowingFilter(
        itemsList: _allItems, filter: _currentFilter);
    _notifyFilteredItemsListChanges();
  }

  void _notifyFilteredItemsListChanges() {
    addData(_filteredItems);
  }

  void clearFilter() {
    _currentFilter = null;
  }

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

  @override
  void reload() {}
}
