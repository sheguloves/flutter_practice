import 'package:flutter/material.dart';
import 'package:note_demo/components/note_page/note_detail.dart';
import 'package:note_demo/models/global_context.dart';
import 'package:note_demo/models/note.dart';
import 'package:provider/provider.dart';

class NoteItem extends StatefulWidget {
  const NoteItem({required this.note, super.key});
  final Note note;

  @override
  NoteItemState createState() => NoteItemState();
}

class NoteItemState extends State<NoteItem> {

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalContext>(
      builder: (context, globalContext, child) {
        return globalContext.showDelete
          ? CheckboxListTile(
              value: widget.note.selected,
              onChanged: (value) {
                setState(() {
                  widget.note.selected = value == true;
                });
              },
              key: Key(widget.note.id),
              title: Text(widget.note.title),
              tileColor: Colors.deepPurple.shade400,
            )
          : ListTile(
              key: Key(widget.note.id),
              title: Text(widget.note.title),
              tileColor: Colors.deepPurple.shade400,
              onLongPress:() {
                final globalContext = context.read<GlobalContext>();
                globalContext.turnOnDelete();
              },
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoteDetail(note: widget.note),
                  ),
                );
              },
            );
      }
    );
  }
}