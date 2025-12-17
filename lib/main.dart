import 'package:flutter/material.dart';
import 'package:flutter_provider_ex01/provider/todo_provider.dart';
import 'package:flutter_provider_ex01/view/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (context) => TodoProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => const Home();
}
