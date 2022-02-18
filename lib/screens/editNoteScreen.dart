import 'package:add_notes_project/model/notesDataModel.dart';
import 'package:add_notes_project/services/notesProvider.dart';
import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  EditScreen({Key? key, this.newNote}) : super(key: key);
  Notes? newNote;
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final noteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime? dateController;


  @override
  void initState() {
   noteController.text = widget.newNote!.note.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
            
                  controller: noteController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Note',
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
                          dateController = value ??
                              DateTime.parse(widget.newNote!.date.toString());
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
                      Notes note = Notes(
                          columnId: widget.newNote!.columnId,
                          note: noteController.text.isNotEmpty
                              ? noteController.value.text
                              : widget.newNote!.note,
                          date: dateController.toString());
                      NotesDatabase.instance
                          .update(note)
                          .then((value) => Navigator.of(context).pop());
                    },
                    child: Text("update")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
