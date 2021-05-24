// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:homepage_and_exercise/exercisepage.dart';
import 'main.dart';

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = TextStyle(fontSize: 18.0);
  @override

  // build function
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: null,
        ),
        title: Text('Your exercise list'),
      ),
      body: _buildSuggestions(),
      //body: Center(
      //child: MyButton(),
      //),
    );
  }

  // build suggestions function
  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          /* 
    1   The itemBuilder callback is called once per suggested word pairing, and places each suggestion into a ListTile row. For even rows, the function adds a ListTile row for the word pairing. For odd rows, the function adds a Divider widget to visually separate the entries. Note that the divider might be difficult to see on smaller devices.
    2   Add a one-pixel-high divider widget before each row in the ListView.
    3   The expression i ~/ 2 divides i by 2 and returns an integer result. For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2. This calculates the actual number of word pairings in the ListView, minus the divider widgets.
    4   If you’ve reached the end of the available word pairings, then generate 10 more and add them to the suggestions list.
        */
          return _buildRow(_suggestions[index], index);
        });
  }

  // build row function
  Widget _buildRow(WordPair pair, int index) {
    return ListTile(
        onTap: () {
          print('Item $pair was tapped!');
          Navigator.pushNamed(context, OverallScaffold.routeName,
              arguments: ScreenArguments(pair.first, pair.second));
        },
        leading: FlutterLogo(),
        title: Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
        subtitle: Text('Reps: $index, Sets: $index'),
        trailing: Icon(Icons.add));
  }
}
