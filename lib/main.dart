import 'package:flutter/material.dart';

import 'util/formatted_strings.dart';
import 'view/tile_images.dart';
import 'viewmodel/puzzle_viewmodel.dart';

void main() => runApp(TileMatchApp());

class TileMatchApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tile Match',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.teal,
        accentColor: Colors.brown,
      ),
      home: TileMatchScreen(title: 'Tile Match'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TileMatchScreen extends StatefulWidget {
  final String title;

  TileMatchScreen({Key? key, required this.title}) : super(key: key);

  @override
  _TileMatchScreenState createState() => _TileMatchScreenState();
}

class _TileMatchScreenState extends State<TileMatchScreen> {
  final _viewmodel;

  _TileMatchScreenState() : _viewmodel = PuzzleViewModel() {
    _newPuzzle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          StreamBuilder<int>(
            stream: _viewmodel.tickStream,
            builder: (context, snapshot) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    ticksToHms(snapshot.data ?? 0),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.merge(TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            tooltip: 'New puzzle',
            onPressed: _newPuzzle,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // No children in main content area yet.
          ],
        ),
      ),
    );
  }

  _newPuzzle() => _viewmodel.newPuzzle(tileImages.length);
}
