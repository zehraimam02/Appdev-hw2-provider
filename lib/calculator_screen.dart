import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hw2_calculator/Provider/calculator_provider.dart';
import 'package:provider/provider.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  Map<String, bool> buttonStates = {};
  void handleTap(String text) {
    setState(() {
      buttonStates[text] = true;
    });
    // Calling provider
    Provider.of<CalculatorProvider>(context, listen:false).setValue(text);

    // To change button color on state change
    Timer(const Duration(milliseconds: 100), (){
      setState(() {
        buttonStates[text] = false;
      });
    });
  }  

 
  final numberBgColor = Colors.grey[800]!;
  final symbolBgColor = Colors.amber[800]!;

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorProvider>(builder: (context, provider,_){
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            Align(
              alignment: Alignment.centerRight, 
              child: Column(
                mainAxisSize: MainAxisSize.min, // Allows the column to wrap the content
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Calculation history text
                  Text(
                    provider.calculationHistory,
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400, 
                    ),
                  ),

                  // Main display text
                  Text(
                    provider.displayText,  // To display the text in the screen
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 80, 
                      color: Colors.white,
                      fontWeight: FontWeight.w200,
                    ),
                  ), 
                  
                ],
              )
            ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  numberButton(Colors.grey[400]!, "AC", Colors.black),
                    numberButton(Colors.grey[400]!, "+/-", Colors.black),
                      numberButton(Colors.grey[400]!, "%", Colors.black),
                        numberButton(symbolBgColor, "÷", Colors.white),
                ],
              ), SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  numberButton(numberBgColor, "7", Colors.white),
                    numberButton(numberBgColor, "8", Colors.white),
                      numberButton(numberBgColor, "9", Colors.white),
                        numberButton(symbolBgColor, "×", Colors.white),
                ],
              ), SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  numberButton(numberBgColor, "4", Colors.white),
                    numberButton(numberBgColor, "5", Colors.white),
                      numberButton(numberBgColor, "6", Colors.white),
                        numberButton(symbolBgColor, "-", Colors.white),
                ],
              ), SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  numberButton(numberBgColor, "1", Colors.white),
                    numberButton(numberBgColor, "2", Colors.white),
                      numberButton(numberBgColor, "3", Colors.white),
                        numberButton(symbolBgColor, "+", Colors.white),
                ],
              ), 
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: numberBgColor, 
                      shape: StadiumBorder(), 
                      padding: EdgeInsets.fromLTRB(35, 14, 128, 14)
                    ),
                    onPressed: ()=> Provider.of<CalculatorProvider>(context, listen:false).setValue("0"), 
                    child: const Text(
                      "0", 
                      style: TextStyle(
                        fontWeight: FontWeight.normal, 
                        fontSize: 35, 
                        color: Colors.white,
                      ),
                    ),
                  ),
                  numberButton(numberBgColor, ".", Colors.white),
                  numberButton(symbolBgColor, "=", Colors.white),
                ],
              )
            ],
          ),
        ),
      ),
    );
  });
  }
  Widget numberButton(
    Color bgColor,
    String text,
    Color textColor,
  ){
    bool isChange = buttonStates[text] ?? false;
    return GestureDetector(
      onTap: () => handleTap(text),
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isChange?Colors.white38: bgColor,
        ),
        child: Center(
          child: Text(
          text, 
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.normal, 
            fontSize: 35, 
            color: textColor,
          ),
          ),
        ),
      ),
    );
  }
}