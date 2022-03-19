import 'package:flutter/material.dart';
import 'package:tf_filterable_list/tf_filterable_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Create instance of TfFilterableList with template parameter matching
  // the data type of items list is going to hold
  final numbersList = TfFilterableList<int>();

  @override
  void initState() {
    super.initState();
    // Must initialize the instance before using.
    numbersList.init();
    // Let us add 100 numbers to the list.
    numbersList.addItems(List<int>.generate(100, (index) => index + 1));
    // Applying the changes.
    numbersList.apply();
  }

  @override
  void dispose() {
    // Make sure to dispose the instance after use.
    numbersList.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      // The floating button is provided to add 10 items to numbers list.
      floatingActionButton: FloatingActionButton(
        child: const Text(
          '+10',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          final newItemsToAdd = List.generate(
              10, (index) => numbersList.allItems.last + index + 1);
          // Add new items to the list.
          numbersList.addItems(newItemsToAdd);
          // Applying to notify listeners and update UI.
          numbersList.apply();
        },
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                // To provide input for divisor
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Enter divisor',
                    contentPadding: EdgeInsets.all(4),
                  ),
                  keyboardType: TextInputType.number,
                  onSubmitted: (input) {
                    final divisor = int.tryParse(input);
                    if (divisor != null) {
                      // Update the filter to support new divisor
                      numbersList.setFilter((item) => item % divisor == 0);
                      // Apply to reflect the changes in UI.
                      numbersList.apply();
                    }
                  },
                ),
              ),
              InkWell(
                child: const Icon(Icons.cancel),
                onTap: () {
                  // Clear all the items.
                  numbersList.clearFilter();
                  // Apply to reflect changes in UI.
                  numbersList.apply();
                },
              ),
            ],
          ),
          Expanded(
            child: StreamBuilder<List<int>>(
              stream: numbersList.streamOfFilteredItems,
              builder: (context, snapshot) {
                final filteredNumbers = snapshot.data;
                if (filteredNumbers != null) {
                  return _buildNumbersList(filteredNumbers);
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumbersList(List<int> filteredNumbers) {
    return ListView(
      children: filteredNumbers.map<Widget>((item) {
        return ListTile(
          title: Text(item.toString()),
        );
      }).toList(),
    );
  }
}
