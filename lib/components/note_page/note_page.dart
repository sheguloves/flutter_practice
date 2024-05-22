import 'package:flutter/material.dart';
import 'package:note_demo/components/note_page/note_item.dart';
import 'package:note_demo/services/local_storage.dart';
import 'package:uuid/uuid.dart';

import '../../models/note.dart';

class NotePage extends StatefulWidget {

  NotePage({ super.key });

  final LocalStorage storage = LocalStorage();

  @override
  NotePageState createState() => NotePageState();
}

class NotePageState extends State<NotePage> {

  final List<Note> _notes = [];

  final uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    widget.storage.readNotes().then((value) {
      setState(() {
        if (value.isNotEmpty) {
          _notes.clear();
          _notes.addAll(value);
        }
      });
    });
  }

  void _addNewItem() {
    setState(() {
      _notes.add(Note(id: uuid.v1(), title: 'test generated', content: ''));
    });
    widget.storage.writeNotes(_notes);
  }

  void _updateNote(Note old, Note newNote) {
    setState(() {
      final index = _notes.indexOf(old);
      _notes.removeAt(index);
      _notes.insert(index, newNote);
    });
    widget.storage.writeNotes(_notes);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          children: _notes.map((note) {
            return Column(
              children: [
                NoteItem(note: note, updateCallback: (Note newNote) {
                  _updateNote(note, newNote);
                }),
                const Divider(height: 10),
              ],
            );
          }).toList(),
        ),
        Positioned(
          right: 10,
          bottom: 10,
          child: FloatingActionButton(
            onPressed: _addNewItem,
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}