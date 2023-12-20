import 'package:calculator/utilities/button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var userQuestion = '';
  var userAnswer = '';

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
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(userQuestion, style: const TextStyle(fontSize: 20, fontFamily: 'digital'),)),
                    // Divider(thickness: 1,),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(userAnswer, style: TextStyle(fontSize: 20),))
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                 itemBuilder: (BuildContext context, int index) {
                  if(index == 0) {
                     return MyButton(
                      buttonTapped: () {
                        setState(() {
                          userQuestion = '';
                          userAnswer = '';
                        });
                      },
                    color:  Colors.green,
                    textColor: Colors.white,
                    buttonText: buttons[index],);
                  } else if (index == 1) {
                     return MyButton(
                      buttonTapped: () {
                        if(userQuestion.isNotEmpty) {
                          setState(() {
                          userQuestion = userQuestion.substring(0, userQuestion.length-1);
                        });
                        } else {
                          return userQuestion = '';
                        }
                      },
                    color:  Colors.red,
                    textColor: Colors.white,
                    buttonText: buttons[index],);
                  } else if(index == buttons.length-1) {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            equalPressed();
                          });
                        },
                        color: Colors.deepPurpleAccent,
                        buttonText: buttons[index],
                        textColor: Colors.white,
                      );
                  }else {
                     return MyButton(
                    buttonTapped: () {
                      setState(() {
                        userQuestion += buttons[index];
                      });
                    } ,
                    color:  isOperator(buttons[index]) ? Colors.deepPurple : Colors.deepPurple[50],
                    textColor: isOperator(buttons[index]) ? Colors.deepPurple[50] : Colors.deepPurple,
                    buttonText: buttons[index],);
                  }
                  
                 }),
            ),
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

  void equalPressed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('X', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    if (eval % 1 == 0) {
      userAnswer = eval.toInt().toString();
    } else {
    userAnswer = eval.toString();
    }   
  }
}
