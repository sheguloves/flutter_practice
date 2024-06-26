import 'package:flutter/material.dart';
import 'package:note_demo/components/favorite_page.dart';
import 'package:note_demo/components/note_page/note_page.dart';
import 'package:note_demo/providers/note_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {

  const HomePage({ super.key });

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  late TabController _controller;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _controller.addListener(() {
      setState(() {
        _index = _controller.index;
      });
    });
    Provider.of<NoteProvider>(context, listen: false).getNotes();
  }

  @override
  Widget build(BuildContext context) {   

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: const [],
      ),
      body: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade50,
          ),
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _controller,
            children: const <Widget>[
              NotePage(),
              FavoritePage(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (index) {
          setState(() {
            _controller.index = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.article_rounded),
            label: 'Note',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_rounded),
            label: 'Favorite',
          ),
        ],
      ),
    );
  }
}