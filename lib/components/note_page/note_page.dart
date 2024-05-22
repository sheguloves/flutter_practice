import 'package:flutter/material.dart';
import 'package:note_demo/components/note_page/note_item.dart';
import 'package:note_demo/services/local_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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

  void _removeItem(Note note) {
    setState(() {
      _notes.remove(note);
      widget.storage.writeNotes(_notes);
    });
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
            return Slidable(
              // Specify a key if the Slidable is dismissible.
              key: Key(note.id),

              // The start action pane is the one at the left or the top side.
              startActionPane: ActionPane(
                // A motion is a widget used to control how the pane animates.
                motion: const ScrollMotion(),
                // All actions are defined in the children parameter.
                children: [
                  // A SlidableAction can have an icon and/or a label.
                  SlidableAction(
                    onPressed: (context) {
                      _removeItem(note);
                    },
                    backgroundColor: const Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),

              // The end action pane is the one at the right or the bottom side.
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                    },
                    backgroundColor: const Color(0xFF7BC043),
                    foregroundColor: Colors.white,
                    icon: Icons.favorite,
                    label: 'Favorite',
                  ),
                ],
              ),

              // The child of the Slidable is what the user sees when the
              // component is not dragged.
              child: NoteItem(note: note, updateCallback: (newNote) {
                _updateNote(note, newNote);
              }),
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