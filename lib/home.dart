import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_shop/product.dart';
import 'package:provider/provider.dart';

import 'main.dart';
import 'dart:math';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;
    const title = 'Product List';

    late Future<List<Product>> futureProducts;
    futureProducts = fetchProducts();

    IconData icon;
    icon = Icons.shopping_basket;

    final currentCount = (MediaQuery.of(context).size.width ~/ 400).toInt();

    final imgHeight = (MediaQuery.of(context).size.height ~/ 8).toDouble();
    final imgWidth = (MediaQuery.of(context).size.width ~/ 2).toDouble();

    final minCount = 1;

    return MaterialApp(
      title: title,
      home: Scaffold(
        body: FutureBuilder<List<Product>>(
          future: futureProducts,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                  itemCount: snapshot.data?.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: max(currentCount, minCount),
                    childAspectRatio: 1,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  itemBuilder: (context, index) => Center(
                      child: Card(
                          child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                minHeight: 300,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image(
                                    width: imgWidth,
                                    height: imgHeight,
                                    image: NetworkImage(
                                        snapshot.data![index].thumbnail),
                                  ),
                                  Text(
                                    snapshot.data![index].category
                                        .toCapitalized(),
                                  ),
                                  ListTile(
                                    title: Text(
                                        snapshot.data![index].title
                                            .toTitleCase(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis),
                                    subtitle: Text(
                                        snapshot.data![index].description,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  RatingBarIndicator(
                                    rating:
                                        snapshot.data![index].rating.toDouble(),
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 5,
                                    itemSize: 30.0,
                                    direction: Axis.horizontal,
                                  ),
                                  // SizedBox(height: 10),
                                  Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Expanded(
                                          child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${snapshot.data![index].price} €",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              appState.addToCart(
                                                  snapshot.data![index]);
                                            },
                                            icon: Icon(icon),
                                          ),
                                        ],
                                      ))),
                                ],
                              )))));
            } else if (snapshot.hasError) {
              return const Text(
                  "An error has occured, please try again later !");
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
