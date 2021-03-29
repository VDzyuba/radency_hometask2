import 'package:flutter/material.dart';
import 'package:radency_hometask/contacts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _isFavorite = <bool>[];
  final _firstName = [];
  final _lastName = [];
  final _company = [];
  final _images = [];

  void createLists() {
    for (var i in contacts) {
      if (i['company'] == null) {
        _company.add('');
      } else {
        _company.add(i['company']);
      }
      if (i['firstName'] == null) {
        _firstName.add('');
      } else {
        _firstName.add(i['firstName']);
      }
      _isFavorite.add(false);
      _lastName.add(i['lastName']);
      _images.add(i['images']);
    }
  }

  void sortByLastName() {
    contacts.sort((a, b) {
      var r = a["lastName"].compareTo(b["lastName"]);
      if (r != 0) return r;
      return a["firstName"].compareTo(b["firstName"]);
    });
  }

  @override
  void initState() {
    sortByLastName();
    createLists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Radency Hometask #2'),
      ),
      body: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 0.0),
                  child: groupByAlphabetic(index),
                ),
                Row(
                  children: [
                    Container(
                      width: 40.0,
                      child: IconButton(
                          icon: _isFavorite[index]
                              ? Icon(Icons.star)
                              : Icon(Icons.star_border),
                          color: Colors.blue,
                          onPressed: () {
                            setState(() {
                              _isFavorite[index] = !_isFavorite[index];
                            });
                          }),
                    ),
                    Expanded(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('lib/assets/${_images[index]}'),
                          backgroundColor: Colors.blue,
                        ),
                        title: Text('${_firstName[index]} ${_lastName[index]}',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(_company[index]),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
    );
  }

  Text groupByAlphabetic(int index) {
    var textStyle = TextStyle(
        fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.grey);

    var firstLetter = _lastName[index].toString().substring(0, 1);
    if (--index >= 0) {
      if (firstLetter != _lastName[index--].toString().substring(0, 1)) {
        return Text(
          firstLetter,
          style: textStyle,
        );
      }
    } else {
      return Text(firstLetter, style: textStyle);
    }
  }
}
