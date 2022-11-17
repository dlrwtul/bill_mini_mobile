import 'package:bill_mini_mobile/views/partenaire_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: 'Bill api payment'),
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
  TextEditingController textController = TextEditingController();

  Widget partenairesList = PartenaireList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 180.0,
        elevation: 0.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(60),
          ),
        ),
        backgroundColor: Colors.grey.shade200,
        title: Container(
          padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 3.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.orange.shade300),
          child: TextField(
            controller: textController,
            decoration: const InputDecoration(
                hintText: 'Nom commercial',
                icon: Icon(Icons.search),
                prefixIconColor: Colors.black,
                label: Text('search'),
                labelStyle: TextStyle(color: Colors.black)),
            onChanged: (value) {
              setState(() {
                partenairesList = PartenaireList(
                  nomCommercial: textController.text,
                );
              });
            },
          ),
        ),
      ),
      body:
          partenairesList, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
