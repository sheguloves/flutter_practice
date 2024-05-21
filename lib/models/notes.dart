import 'package:flutter/material.dart';
import 'package:note_demo/models/note.dart';
import 'package:note_demo/services/local_storage.dart';
import 'package:uuid/uuid.dart';

class Notes with ChangeNotifier {
  Notes() {
    _storage.readNotes().then((value) {
      if (value.isNotEmpty) {
        _notes.clear();
        _notes.addAll(value);
      }
    });
  }

  final _uuid = const Uuid();
  final LocalStorage _storage = LocalStorage();
  final List<Note> _notes = [];

  get notes => _notes;

  void addNewNote() {
    _notes.add(Note(id: _uuid.v1(), title: 'test generated', content: ''));
    _storage.writeNotes(_notes);
    notifyListeners();
  }

  void deleteNotes() {
    _notes.removeWhere((note) => note.selected);
    _storage.writeNotes(_notes);
    notifyListeners();
  }
}