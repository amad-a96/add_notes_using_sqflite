import 'package:add_notes_project/model/notesDataModel.dart';

import 'package:add_notes_project/screens/addNoteScreen.dart';
import 'package:add_notes_project/screens/editNoteScreen.dart';
import 'package:add_notes_project/services/notesProvider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddNoteScreen(),
                    ));
              },
              child: Text('add')),
          TextButton(
              onPressed: () {
                setState(() {});
              },
              child: Text("refresh"))
        ],
      ),
      body: FutureBuilder<List<Notes>>(
        future: NotesDatabase.instance.readAllNotes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data!.length.toString());
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return noteCard(snapshot.data![index]);
                });
          } else {
            return LinearProgressIndicator();
          }
        },
      ),
    );
  }

  Widget noteCard(snapshot) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EditScreen(
              newNote: snapshot,
            ),
          ));
        },
        /* child: ListTile(
          title: Text(snapshot.note.toString()),
          subtitle: Text(snapshot.date.toString()),
        ),*/
        child: Dismissible(
          key: Key(snapshot.toString()),
          onDismissed: (direction) {
            setState(() {
              NotesDatabase.instance.delete(snapshot.columnId);
            });
          },
          child: ListTile(
            title: Text(snapshot.note.toString()),
            subtitle: Text(snapshot.date.toString()),
          ),
        ),
      ),
    );
    //Text(snapshot.note.toString());
  }
}
