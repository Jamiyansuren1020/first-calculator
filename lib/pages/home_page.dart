import 'package:calculator/utilities/button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<String> buttons = 
  [
    'C', 'DEL' , '%' , '/',
    '9', '8' , '7' , 'X',
    '6', '5' , '4' , '--',
    '3', '2' , '1' , '+',
    '0', '.' , 'ANS' , '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Text('12312313'),
          ),
          Container(
            child: GridView.builder(
              itemCount: buttons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
               itemBuilder: (BuildContext context, int index) {
                if(index == 0) {
                   return MyButton(
                  color:  Colors.green,
                  textColor: Colors.white,
                  buttonText: buttons[index],);
                } else if (index == 1) {
                   return MyButton(
                  color:  Colors.red,
                  textColor: Colors.white,
                  buttonText: buttons[index],);
                }else {
                   return MyButton(
                  color:  isOperator(buttons[index]) ? Colors.deepPurple : Colors.deepPurple[50],
                  textColor: isOperator(buttons[index]) ? Colors.deepPurple[50] : Colors.deepPurple,
                  buttonText: buttons[index],);
                }
                
               }),
          )
      ]),
    );
  }

  bool isOperator(String x) {
    if(x== '%' || x == '/' || x == 'X' || x == '--' || x == '+' || x == '=') {
      return true;
    } 
    return false;
  }
}
