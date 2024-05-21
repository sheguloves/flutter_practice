import 'package:flutter/material.dart';
import 'package:note_demo/models/note.dart';
import 'package:note_demo/services/local_storage.dart';
import 'package:uuid/uuid.dart';

class Notes with ChangeNotifier {
  Notes(List<Note> initialNotes) {
    _notes.addAll(initialNotes);
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