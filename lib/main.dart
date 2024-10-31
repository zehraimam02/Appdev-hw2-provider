import 'package:flutter/material.dart';
import 'package:hw2_calculator/Provider/calculator_provider.dart';
import 'package:provider/provider.dart';
import 'calculator_screen.dart';


void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CalculatorProvider(),
      child: MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: const Calculator(),
      ),
    );
  }
}
