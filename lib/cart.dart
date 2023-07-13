import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    IconData iconClose;
    iconClose = Icons.close;

    IconData iconMore;
    iconMore = Icons.add;
    IconData iconLess;
    iconLess = Icons.remove;

    if (appState.cart.isEmpty) {
      return Center(
        child: Text('Votre panier est vide.'),
      );
    }

    final imgHeight = (MediaQuery.of(context).size.height ~/ 20).toDouble();
    final imgWidth = (MediaQuery.of(context).size.width ~/ 15).toDouble();

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('You have '
              '${appState.cart.length} item(s) in your shopping cart :'),
        ),
        for (var pair in appState.cart)
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image(
                width: imgWidth,
                height: imgHeight,
                image: NetworkImage(pair.thumbnail),
              ),
              Text(pair.title, maxLines: 1, overflow: TextOverflow.ellipsis),
              Text(
                "${pair.price} €",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      appState.lessFromCart(pair);
                    },
                    icon: Icon(iconLess),
                  ),
                  Text(pair.amount.toString()),
                  IconButton(
                    onPressed: () {
                      appState.addMoreToCart(pair);
                    },
                    icon: Icon(iconMore),
                  ),
                ],
              ),
              Text(
                "${pair.price * pair.amount} €",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {
                  appState.removeFromCart(pair);
                },
                icon: Icon(iconClose),
              ),
            ],
          )
        // ListTile(
        //   leading: Image(
        //     width: 50,
        //     height: 50,
        //     image: NetworkImage(pair.thumbnail),
        //   ),
        //   title:
        //       Text(pair.title, maxLines: 1, overflow: TextOverflow.ellipsis),
        //   trailing: IconButton(
        //     onPressed: () {
        //       appState.removeFromCart(pair);
        //     },
        //     icon: Icon(icon),
        //   ),
        // ),
      ],
    );
  }
}
