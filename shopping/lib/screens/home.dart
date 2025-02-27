import 'package:flutter/material.dart';

import 'package:shopping/models/grocery_item.dart';
import 'package:shopping/screens/new.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  final List<GroceryItem> _items = [];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _addNewItem() async {
    final newItem = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const NewItem()));

    if (newItem != null) {
      setState(() {
        widget._items.add(newItem);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Groceries'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addNewItem,
          ),
        ],
      ),
      body: widget._items.isEmpty
          ? const Center(
              child: Text('No items yet!'),
            )
          : ListView.builder(
              itemCount: widget._items.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(widget._items[index].id),
                  onDismissed: (direction) {
                    setState(() {
                      widget._items.removeAt(index);
                    });
                  },
                  child: ListTile(
                    leading: Container(
                      color: widget._items[index].category.color,
                      width: 20,
                      height: 20,
                    ),
                    title: Text(widget._items[index].name),
                    trailing: Text(widget._items[index].quantity.toString()),
                  ),
                );
              }),
    );
  }
}
