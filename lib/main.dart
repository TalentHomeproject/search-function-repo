import 'package:flutter/material.dart';

void main() => runApp(const ArApp());

class ArApp extends StatelessWidget {
  const ArApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Application name
      title: 'TalentHome',
      // Application theme data, you can set the colors for the application as
      // you want
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      // A widget which will be started on application startup
      home: const MyHomePage(title: 'TalentHome'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});
  static const List<String> texts = [
    'Singing',
    'Chess Master',
    'Skipper',
    'football',
    'Basket Ball Player',
    'Drama',
    'problem solving',
    'Dress Designer',
    'web Designer',
    'Artist'
  ];

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isSearchBarOpen = false;

  final TextEditingController _searchController = TextEditingController();

  List<String> _filteredTexts = MyHomePage.texts;

  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    String searchTerm = _searchController.text.toLowerCase();
    setState(() {
      _filteredTexts = MyHomePage.texts
          .where((text) => text.toLowerCase().contains(searchTerm))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        title: _isSearchBarOpen
            ? TextField(
                controller: _searchController,
                style: TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.white60),
                  border: InputBorder.none,
                ),
              )
            : Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(_isSearchBarOpen ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearchBarOpen = !_isSearchBarOpen;
                if (!_isSearchBarOpen) {
                  _searchController.clear();
                  _filteredTexts = MyHomePage.texts;
                }
              });
            },
          ),
        ],
      ),

      //Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.amber,
        selectedFontSize: 15,
        selectedIconTheme:
            const IconThemeData(color: Colors.amberAccent, size: 30),
        selectedItemColor: Colors.amberAccent,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_sharp, color: Colors.black),
            label: 'Favorites',
          ),

          //
          BottomNavigationBarItem(
            icon: Icon(Icons.recent_actors, color: Colors.black),
            label: 'Recents',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat, color: Colors.black),
            label: 'Chats',
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: MyHomePage.texts.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Card(
                color: Colors.deepPurple,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    MyHomePage.texts[index],
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // void setState(Null Function() param0) {}
}
