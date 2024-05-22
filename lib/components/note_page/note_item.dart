import 'package:flutter/material.dart';
import 'package:note_demo/components/note_page/note_detail.dart';
import 'package:note_demo/models/note.dart';
import 'package:provider/provider.dart';

import '../../providers/note_provider.dart';

class NoteItem extends StatefulWidget {
  const NoteItem({required this.note, required this.updateCallback, super.key});

  final Note note;
  final void Function(Note newNote) updateCallback;

  @override
  NoteItemState createState() => NoteItemState();
}

class NoteItemState extends State<NoteItem> {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NoteProvider>(context);
    return ListTile(
      key: Key(widget.note.id),
      trailing: GestureDetector(
        onTap: () {
          provider.markFavor(widget.note);
        },
        child: widget.note.favorite
          ? const Icon(Icons.favorite, color:Colors.red)
          : const Icon(Icons.favorite_border),
      ),
      title: Text(widget.note.title),
      tileColor: Colors.deepPurple.shade400,
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NoteDetail(note: widget.note),
          ),
        );
        widget.updateCallback(result);
      },
    );
  }
}