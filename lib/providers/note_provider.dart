import 'package:flutter/material.dart';
import 'package:note_demo/services/local_storage.dart';
import 'package:uuid/uuid.dart';

import '../models/note.dart';

class NoteProvider extends ChangeNotifier {
  late List<Note> notes;
  late List<Note> favorNotes;

  final _uuid = const Uuid();

  bool loading = false;

  final service = LocalStorage();

  getNotes() async {
    loading = true;
    notes = await service.readNotes();
    favorNotes = notes.takeWhile((value) => value.favorite).toList();
    loading = false;

    notifyListeners();
  }

  void addNewItem() {
    notes.add(Note(id: _uuid.v1(), title: 'test generated', content: ''));
    _syncFavor();
    service.writeNotes(notes);
    notifyListeners();
  }

  void removeItem(Note note) {
    notes.remove(note);
    _syncFavor();
    service.writeNotes(notes);
    notifyListeners();
  }

  void markFavor(Note note) {
    note.favorite = !note.favorite;
    _syncFavor();
    service.writeNotes(notes);
    notifyListeners();
  }

  void updateNote(Note old, Note newNote) {
    final index = notes.indexOf(old);
    notes.removeAt(index);
    notes.insert(index, newNote);
    _syncFavor();
    service.writeNotes(notes);
    notifyListeners();
  }

  void _syncFavor() {
    // favorNotes.clear();
    // favorNotes.addAll(notes.where((value) => value.favorite));
    favorNotes = notes.where((value) => value.favorite).toList();
  }
}