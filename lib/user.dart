import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  final num id;
  final String firstName;
  final String lastName;
  final num age;
  final String gender;
  final String phone;
  final String email;
  final String username;
  final Map<String, dynamic> address;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.gender,
    required this.phone,
    required this.email,
    required this.username,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as num,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      age: json['age'] as num,
      gender: json['gender'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      address: json['address'] as Map<String, dynamic>,
    );
  }
}

Future<User> fetchUsers() async {
  final response = await http.get(Uri.parse('https://dummyjson.com/users/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final res = json.decode(response.body);
    User user = User.fromJson(res);
    return user;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load user');
  }
}
