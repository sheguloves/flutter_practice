import 'package:flutter/material.dart';
import 'package:note_demo/components/note_page/note_item.dart';
import 'package:note_demo/models/notes.dart';
import 'package:note_demo/services/local_storage.dart';
import 'package:provider/provider.dart';
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          children: _notes.map((note) {
            return Column(
              children: [
                NoteItem(note: note),
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

// class NotePage extends StatelessWidget {

//   const NotePage({ required this.notes, super.key });

//   final List<Note> notes;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         ListView(
//           children: notes.map((note) {
//             return Column(
//               children: [
//                 NoteItem(note: note),
//                 const Divider(height: 10),
//               ],
//             );
//           }).toList(),
//         ),
//         Positioned(
//           right: 10,
//           bottom: 10,
//           child: Consumer<Notes>(
//             builder: (context, notes, child) {
//               return FloatingActionButton(
//                 onPressed: () {
//                   notes.addNewNote();
//                 },
//                 child: const Icon(Icons.add),
//               );
//             }
//           ),
//         ),
//       ],
//     );
//   }
// }