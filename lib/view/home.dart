import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Todo List')),
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: ListView.builder(itemCount: 0, itemBuilder: (context, index) {}),
    ),
  );
}
