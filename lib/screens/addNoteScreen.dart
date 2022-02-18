import 'package:add_notes_project/model/notesDataModel.dart';

import 'package:add_notes_project/services/notesProvider.dart';
import 'package:flutter/material.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final noteController = TextEditingController();
  DateTime dateController = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter some text';
                    }
                  },
                  controller: noteController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Title',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Card(
                  child: InkWell(
                    child: ListTile(
                      title: Row(
                        children: [
                          Icon(Icons.calendar_today_rounded),
                          Text("pick a date"),
                        ],
                      ),
                    ),
                    onTap: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100))
                          .then((value) {
                        setState(() {
                          dateController = value ?? DateTime.now();
                        });
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Notes note = Notes(
                            note: noteController.value.text,
                            date: dateController.toString());
                        NotesDatabase.instance
                            .create(note)
                            .then((value) => Navigator.of(context).pop());
                      }
                    },
                    child: Text("add")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
