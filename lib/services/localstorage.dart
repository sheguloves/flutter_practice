import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../models/note.dart';

class LocalStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/notes.json');
  }

  Future<File> writeNotes(List<Note> notes) async {
    final file = await _localFile;
    final contents = jsonEncode(notes);
    return file.writeAsString(contents);
  }

  Future<List<Note>> readNotes() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();
      Iterable results = json.decode(contents);
      return List<Note>.from(results.map((item)=> Note.fromJson(item)));
    } catch (e) {
      // If encountering an error, return 0
      debugPrint('decode json storage failed');
      return [];
    }
  }
}