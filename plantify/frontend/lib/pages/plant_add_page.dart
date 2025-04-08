import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class PlantAddPage extends StatefulWidget {
  const PlantAddPage({super.key});

  @override
  State<PlantAddPage> createState() => _PlantAddPageState();
}

class _PlantAddPageState extends State<PlantAddPage>{
  final _supabase = Supabase.instance.client;
  final _formKey = GlobalKey<FormState>();
  final _nameContoller = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _speciesController = TextEditingController();

  void _submitForm() async {
    try {
      if (_formKey.currentState!.validate()) {
        final name = _nameContoller.text;
        final description = _descriptionController.text;
        final location = _locationController.text;
        final species = _speciesController.text;
        

        await _supabase
          .from('plants')
          .insert({
          'name': name,
          'description': description,
          'location': location,
          'photo_url': null,
          'species': species,
          'owner_id': _supabase.auth.currentUser?.id,
          });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Dodane roślinę $name'))
          );

          _nameContoller.clear();
          _descriptionController.clear();
          _locationController.clear();
          _speciesController.clear();

          _formKey.currentState!.reset();
      }
    } catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$e'))
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a plant'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameContoller,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: _speciesController,
                decoration: const InputDecoration(labelText: 'Species'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a species';
                  }
                  return null;
                },
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Add plant'),
                ),
              ),
            ],
          ),
        )
        )
    );
  }

}