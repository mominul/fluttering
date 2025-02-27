import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shopping/models/category.dart';
import 'package:shopping/models/grocery_item.dart';
import 'package:shopping/screens/new.dart';
import 'package:shopping/data/categories.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  final List<GroceryItem> _items = [];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData() async {
    final uri = Uri.https(
        "flutter-data-backend-default-rtdb.firebaseio.com", "shopping.json");
    final response = await http.get(uri);

  if (response.body == 'null') {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final Map<String, dynamic> data = jsonDecode(response.body);
    for (final entry in data.entries) {
      String id = entry.key;
      String name = entry.value['name'];
      int quantity = int.parse(entry.value['quantity']);
      Category category = categories.entries
          .firstWhere(
              (element) => element.value.name == entry.value['category'])
          .value;
      setState(() {
        widget._items.add(GroceryItem(
            id: id, name: name, quantity: quantity, category: category));
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _addNewItem() async {
    GroceryItem item = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const NewItem()));

    setState(() {
      widget._items.add(item);
    });
  }

  void _removeItem(index) async {
    GroceryItem item = widget._items[index];

    setState(() {
      widget._items.remove(item);
    });
    
    final uri = Uri.https(
        "flutter-data-backend-default-rtdb.firebaseio.com", "shopping/${item.id}.json");
    final res = await http.delete(uri);
    
    if (res.statusCode >= 400) {
      setState(() {
        widget._items.insert(index, item);
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
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : widget._items.isEmpty
              ? const Center(
                  child: Text('No items yet!'),
                )
              : ListView.builder(
                  itemCount: widget._items.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(widget._items[index].id),
                      onDismissed: (direction) {
                        _removeItem(index);
                      },
                      child: ListTile(
                        leading: Container(
                          color: widget._items[index].category.color,
                          width: 20,
                          height: 20,
                        ),
                        title: Text(widget._items[index].name),
                        trailing:
                            Text(widget._items[index].quantity.toString()),
                      ),
                    );
                  }),
    );
  }
}
