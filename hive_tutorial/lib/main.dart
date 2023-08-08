// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  //* initialize hive
  await Hive.initFlutter();

  //open the box
  var box = await Hive.openBox("mybox");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _myBox = Hive.box("mybox");
  // write data method
  void writeData() {
    _myBox.put(1, "Write");
  }

  // read data method
  void readData() {
    print(_myBox.get(1));
  }

  //delete data method
  void deleteData() {
    _myBox.delete(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              onPressed: writeData,
              child: Text("WRITE"),
              color: Colors.blue,
            ),
            MaterialButton(
              onPressed: readData,
              child: Text("Read"),
              color: Colors.blue,
            ),
            MaterialButton(
              onPressed: deleteData,
              child: Text("DELETE"),
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
