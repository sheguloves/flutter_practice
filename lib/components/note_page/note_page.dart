import 'package:flutter/material.dart';
import 'package:note_demo/components/note_page/note_item.dart';
import 'package:note_demo/models/note.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../providers/note_provider.dart';
import 'note_detail.dart';

class NotePage extends StatefulWidget {

  const NotePage({ super.key });

  @override
  NotePageState createState() => NotePageState();
}

class NotePageState extends State<NotePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NoteProvider>(context);
    return provider.loading
      ? const Center(
          child: CircularProgressIndicator(),
        )
      : Stack(
          children: [
            ListView(
              children: provider.notes.map((note) {
                return Column(
                  children: [
                    Slidable(
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
                              provider.removeItem(note);
                            },
                            backgroundColor: const Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),

                      // The child of the Slidable is what the user sees when the
                      // component is not dragged.
                      child: NoteItem(note: note, updateCallback: (newNote) {
                        if (newNote != null) {
                          provider.updateNote(note, newNote);
                        }
                      }),
                    ),
                    const Divider(),
                  ],
                );
              }).toList(),
            ),
            Positioned(
              right: 10,
              bottom: 10,
              child: FloatingActionButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoteDetail(note: Note(id: 'Untitled', title: 'Untitled', content: '')),
                    ),
                  );
                  if (result != null) {
                    provider.addNewItem(result.title, result.content);
                  }
                },
                child: const Icon(Icons.add),
              ),
            ),
          ],
        );
  }
}