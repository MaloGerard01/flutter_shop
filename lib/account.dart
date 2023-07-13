import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/user.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    Key _formKey = new Key("test");
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    late Future<User> futureUser;
    futureUser = fetchUsers();

    late TextEditingController _controller;

    return Container(
        padding: EdgeInsets.all(20.0),
        child: Scaffold(
            body: FutureBuilder<User>(
                future: futureUser,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Row(
                            children: <Widget>[
                              const Flexible(
                                child: Image(
                                  width: 400,
                                  height: 400,
                                  image: NetworkImage(
                                      'https://image.dummyjson.com/400'),
                                ),
                              ),
                              Flexible(
                                  child: Column(
                                children: [
                                  TextField(
                                    controller: TextEditingController(
                                        text: snapshot.data!.firstName),
                                    decoration: const InputDecoration(
                                        hintText: 'John', labelText: 'Prénom'),
                                    // style: Theme.of(context).textTheme.body1,
                                  ),
                                  TextField(
                                    controller: TextEditingController(
                                        text: snapshot.data!.lastName),
                                    decoration: InputDecoration(
                                        hintText: 'Doe', labelText: 'Nom'),
                                    // style: Theme.of(context).textTheme.body1,
                                  ),
                                  TextField(
                                    controller: TextEditingController(
                                        text: snapshot.data!.username),
                                    decoration: InputDecoration(
                                        hintText: 'Jodo', labelText: 'Pseudo'),
                                    // style: Theme.of(context).textTheme.body1,
                                  ),
                                ],
                              )),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Flexible(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextField(
                                    keyboardType: TextInputType.phone,
                                    controller: TextEditingController(
                                        text: snapshot.data!.phone),
                                    decoration: InputDecoration(
                                        hintText: '+331020304050',
                                        labelText: 'Téléphone'),
                                    // style: Theme.of(context).textTheme.body1,
                                  ),
                                  TextField(
                                    keyboardType: TextInputType.emailAddress,
                                    controller: TextEditingController(
                                        text: snapshot.data!.email),
                                    decoration: InputDecoration(
                                        hintText: 'john.doe@nonymous.com',
                                        labelText: 'Email'),
                                    // style: Theme.of(context).textTheme.body1,
                                  ),
                                ],
                              )),
                              Flexible(
                                  child: Column(
                                children: [
                                  TextField(
                                    controller: TextEditingController(
                                        text:
                                            snapshot.data!.address['address']),
                                    decoration: InputDecoration(
                                        hintText: '42 rue de test',
                                        labelText: 'Adresse'),
                                    // style: Theme.of(context).textTheme.body1,
                                  ),
                                  TextField(
                                    keyboardType: TextInputType.number,
                                    controller: TextEditingController(
                                        text: snapshot
                                            .data!.address['postalCode']),
                                    decoration: InputDecoration(
                                        hintText: '35000',
                                        labelText: 'Code postal'),
                                    // style: Theme.of(context).textTheme.body1,
                                  ),
                                  TextField(
                                    controller: TextEditingController(
                                        text: snapshot.data!.address['city']),
                                    decoration: InputDecoration(
                                        hintText: 'Rennes', labelText: 'Ville'),
                                    // style: Theme.of(context).textTheme.body1,
                                  ),
                                ],
                              )),
                            ],
                          ),
                        ],
                      ),
                      //]
                    );
                  } else if (snapshot.hasError) {
                    return const Text(
                        "An error has occured, please try again later !");
                  }
                  return const Center(child: CircularProgressIndicator());
                })));
  }
}


                      // TextFormField(
                      //   // keyboardType: TextInputType
                      //   //     .emailAddress, // Use email input type for emails.
                      //   decoration: const InputDecoration(
                      //       hintText: 'John', labelText: 'Prénom'),
                      //   // validator: this._validateEmail,
                      //   // onSaved: (String value) {
                      //   //   this._data.email = value;
                      //   // }
                      // ),