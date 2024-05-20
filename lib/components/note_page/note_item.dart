import 'package:flutter/material.dart';
import 'package:note_demo/models/note.dart';

class NoteItem extends StatelessWidget {

  const NoteItem({required this.note, super.key});

  final Note note;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: Key(note.id),
      title: Text(note.title),
      tileColor: Colors.deepPurple.shade400,
    );
  }
}