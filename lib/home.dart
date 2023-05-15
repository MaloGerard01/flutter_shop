import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;
    const title = 'Grid List';

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return MaterialApp(
      title: title,
      home: Scaffold(
        body: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 2,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(20, (index) {
            return Center(
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      title: Text('The Enchanted Nightingale'),
                      subtitle:
                          Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            appState.addToCart("test");
                          },
                          icon: Icon(icon),
                          label: Text('Ajouter'),
                        ),
                        SizedBox(width: 10),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     appState.getNext();
                        //   },
                        //   child: Text('Next'),
                        // ),
                      ],
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     TextButton(
                    //       child: const Text('BUY TICKETS'),
                    //       onPressed: () {/* ... */},
                    //     ),
                    //     const SizedBox(width: 8),
                    //     TextButton(
                    //       child: const Text('LISTEN'),
                    //       onPressed: () {/* ... */},
                    //     ),
                    //     const SizedBox(width: 8),
                    //   ],
                    // ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   var appState = context.watch<MyAppState>();
  //   var pair = appState.current;

  //   IconData icon;
  //   if (appState.favorites.contains(pair)) {
  //     icon = Icons.favorite;
  //   } else {
  //     icon = Icons.favorite_border;
  //   }

  //   return Center(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         BigCard(pair: pair),
  //         SizedBox(height: 10),
  //         Row(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             ElevatedButton.icon(
  //               onPressed: () {
  //                 appState.toggleFavorite();
  //               },
  //               icon: Icon(icon),
  //               label: Text('Test'),
  //             ),
  //             SizedBox(width: 10),
  //             ElevatedButton(
  //               onPressed: () {
  //                 appState.getNext();
  //               },
  //               child: Text('Next'),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
