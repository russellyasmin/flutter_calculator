import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:math_expressions/math_expressions.dart';

class BasicCalculator extends StatefulWidget {
  const BasicCalculator({super.key});

  @override
  State<BasicCalculator> createState() => _BasicCalculatorState();
}

class _BasicCalculatorState extends State<BasicCalculator> {
  TextEditingController numOne = TextEditingController();
  TextEditingController operator = TextEditingController();
  TextEditingController numTwo = TextEditingController();
  String answer = "";

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    double txt = MediaQuery.of(context).textScaleFactor;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
          title: Text(
            "Calculator",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //first number
                Container(
                  padding: EdgeInsets.all(10 * txt),
                  width: w * 0.35,
                  child: TextFormField(
                    cursorColor: Colors.black,
                    controller: numOne,
                    onChanged: (val) {
                      setState(() {
                        numOne.text = val;
                        numOne.selection = TextSelection.fromPosition(
                            TextPosition(offset: numOne.text.length));
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "First number",
                        hintStyle: TextStyle(color: Colors.black)),
                  ),
                ),
                //operator
                Container(
                  padding: EdgeInsets.all(10 * txt),
                  width: w * 0.20,
                  child: TextFormField(
                    cursorColor: Colors.black,
                    controller: operator,
                    onChanged: (val) {
                      setState(() {
                        operator.text = val;
                        operator.selection = TextSelection.fromPosition(
                            TextPosition(offset: operator.text.length));
                      });
                    },
                    decoration: InputDecoration(
                        hintText: "(+ | - | *)",
                        hintStyle: TextStyle(color: Colors.black)),
                  ),
                ),
                //second number
                Container(
                  padding: EdgeInsets.all(10 * txt),
                  width: w * 0.35,
                  child: TextFormField(
                    cursorColor: Colors.black,
                    controller: numTwo,
                    onChanged: (val) {
                      setState(() {
                        numTwo.text = val;
                        numTwo.selection = TextSelection.fromPosition(
                            TextPosition(offset: numTwo.text.length));
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "Second number",
                        hintStyle: TextStyle(color: Colors.black)),
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: h * 0.4,
              child: Center(
                child: Text(
                  answer == "" ? 'Your answer will display here' : answer,
                  style: TextStyle(
                      fontSize: answer == '' ? 16 * txt : 25 * txt,
                      color: answer == '' ? Colors.black : Colors.black),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: w * 0.4,
                  height: h * 0.05,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      onPressed: () {
                        answer = calc();
                        setState(() {});
                      },
                      child: Text(
                        "Calculate",
                        style: TextStyle(color: Colors.black),
                      )),
                ),
                Container(
                  width: w * 0.4,
                  height: h * 0.05,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      onPressed: () {
                        answer = '';
                        numOne.clear();
                        numTwo.clear();
                        setState(() {});
                      },
                      child: Text(
                        "Clear",
                        style: TextStyle(color: Colors.black),
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    numOne.dispose();
    numTwo.dispose();
    operator.dispose();
    super.dispose();
  }

  String calc() {
    Parser P = Parser();
    Expression e = P.parse('${numOne.text + operator.text + numTwo.text}');
    ContextModel cm = ContextModel();
    num answer = e.evaluate(EvaluationType.REAL, cm);
    return answer.toString().length > 10
        ? answer.toStringAsPrecision(3)
        : answer.toString();
  }
}
