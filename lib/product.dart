import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Product {
  final num id;
  final String title;
  final String description;
  final num price;
  final num discount;
  final num rating;
  final num stock;
  final String brand;
  final String category;
  final String thumbnail;
  num amount;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discount,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.amount,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as num,
      title: json['title'] as String,
      description: json['description'] as String,
      price: json['price'] as num,
      discount: json['discountPercentage'] as num,
      rating: json['rating'] as num,
      stock: json['stock'] as num,
      brand: json['brand'] as String,
      category: json['category'] as String,
      thumbnail: json['thumbnail'] as String,
      amount: 1,
    );
  }
}

Future<List<Product>> fetchProducts() async {
  final response = await http.get(Uri.parse('https://dummyjson.com/products'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // debugPrint(response.body);
    // return Album.fromJson(jsonDecode(response.body));
    List<Product> products = [];
    // final res = jsonDecode(response.body);
    var jsonResponse = json.decode(response.body);
    final res = jsonResponse['products'];
    products.addAll(List<Product>.from((res).map((x) => Product.fromJson(x))));
    return products;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load products');
  }
}
