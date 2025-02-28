import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:places/providers/places.dart';
import 'package:places/widgets/image_input.dart';

class NewPlaceScreen extends ConsumerStatefulWidget {
  const NewPlaceScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewPlaceScreenState();
}

class _NewPlaceScreenState extends ConsumerState<NewPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  File? _pickedImage;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_pickedImage == null) {
        return;
      }

      ref.read(placesProvider.notifier).addPlace(
        _title,
        _pickedImage!,
      );
      Navigator.of(context).pop();
    }
  }

  void onPickImage(image) {
    _pickedImage = image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a New Place"),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Form(
            key: _formKey,
            child: TextFormField(
              decoration: InputDecoration(
                labelText: "Title",
              ),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a title.";
                }
                return null;
              },
              onSaved: (newValue) => _title = newValue!,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ImageInput(onPickImage: onPickImage),
          SizedBox(
            height: 20,
          ),
          Center(
            child: ElevatedButton(
              onPressed: _submit,
              child: Text("Add Place"),
            ),
          ),
        ]),
      ),
    );
  }
}
