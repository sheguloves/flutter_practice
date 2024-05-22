import 'package:flutter/material.dart';
import 'package:note_demo/models/note.dart';

class NoteDetail extends StatefulWidget {
  const NoteDetail({required this.note, super.key });

  final Note note;

  @override
  NoteDetailState createState() => NoteDetailState();
}

class NoteDetailState extends State<NoteDetail> {

  final TextEditingController _controller = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.note.content;
    _titleController.text = widget.note.title;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          Navigator.pop(context, widget.note);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            textAlign: TextAlign.center,
            maxLines: 1,
            controller: _titleController,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
          ),
          actions: [
            TextButton( 
              onPressed: () {
                Navigator.pop(context, Note(
                  id: widget.note.id,
                  title: _titleController.text,
                  content: _controller.text,
                ));
              },
              child: const Text('Save'),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade50,
          ),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    autofocus: true,
                    expands: true,
                    minLines: null,
                    maxLines: null,
                    controller: _controller,
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}