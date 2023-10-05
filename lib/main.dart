import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('API Data in ListView'),
        ),
        body: ApiListView(),
      ),
    );
  }
}

class ApiListView extends StatefulWidget {
  @override
  _ApiListViewState createState() => _ApiListViewState();
}

class _ApiListViewState extends State<ApiListView> {
  List<dynamic> _data = [];

  @override
  void initState() {
    super.initState();
    fetchData(); //
  }

  Future<void> fetchData() async {
    final response =
    await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {

      setState(() {
        _data = jsonDecode(response.body);
      });
    } else {

      print('Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _data.length,
      itemBuilder: (context, index) {
        final item = _data[index];
        return ListTile(
          title: Text(item['title']),
          subtitle: Text('User ID: ${item['userId']}'),
        );
      },
    );
  }
}
