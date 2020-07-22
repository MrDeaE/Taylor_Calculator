import 'package:flutter/material.dart';
import 'dart:math' as math;

class Taylor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TaylorState();
  }
}

class _TaylorState extends State<Taylor> {
  String inputText;
  TextEditingController controller = TextEditingController();

  num n = 0;
  num output = 0;
  num diff = 0;
  String diffString;
  num sin = 0;
  num resultFromMath = 0;
  num pi = math.pi;

  @override
  Widget build(BuildContext context) {
    print("enter the value");

    return Scaffold(
      appBar: AppBar(
        title: Text('Taylor series'),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Enter number',
            ),
            TextField(
              autofocus: false,
              controller: controller,
              autocorrect: false,
              textAlign: TextAlign.center,
              maxLength: 4,
              textInputAction: TextInputAction.done,
              onChanged: (text) {
                // changeState();
              },
              decoration: const InputDecoration(
                  hintText: 'What do you want to calculate?',
                  fillColor: Colors.yellow,
                  border: OutlineInputBorder()),
              keyboardAppearance: Brightness.dark,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            Text(
              'sin(' + controller.text + ') =',
              style: TextStyle(fontSize: 22),
            ),
            Text(
              '$output',
              style: TextStyle(fontSize: 22),
            ),
            Text('Result from Math class: $sin'),
            Text('Difference: $diffString'),
            FloatingActionButton(
              onPressed: () {
                changeState();
              },
              child: Text('Enter!'),
            ),
          ],
        ),
      ),
    );
  }

  void changeState() {
    String inputText = controller.text;
    num inputNum = num.parse(inputText);
    num n = getQuadrant(convertFromRadians(inputNum));
    // num n = getQuadrant(30);
    print("n: $n");
    setState(() {
      n = convertToRadians(n);
      output = taylor(n);
    });

    print("result sin is: $output");

    // resultFromMath = math.sin(convertToRadians(30));
    resultFromMath = math.sin(inputNum);
    print('result from Math class: $resultFromMath');
  }

  num convertFromRadians(num radians) {
    return radians * 180 / math.pi;
  }

  num convertToRadians(num degrees) {
    num radians;
    num pi = math.pi;
    radians = (pi / 180) * degrees;
    return radians;
  }

  num getQuadrant(num angle) {
    print("angle: $angle");
    while (angle > 360) {
      angle = angle - 360;
    }

    while (angle < 0) {
      angle = angle + 360;
    }
    print("angle: $angle");
    return angle;
  }

  num factorial(num n) {
    num fact = 1;
    for (num i = 2; i <= n; i++) {
      fact = fact * i;
    }
    return fact;
  }

  //  calculates the power of x
  num power(num x, num n) {
    num output = 1;
    while (n > 0) {
      output = (x * output);
      n--;
    }
    return output;
  }

//value of sin by Taylors series
  num taylor(num radians) {
    num counter = 1;
    num a, b, c;
    num result = 0;
    diff = 0;
    sin = math.sin(radians);
    for (num i = 0; i != 10; i++) { //
      a = power(-1, i); //znak
      b = power(radians, (2 * i) + 1); //radian
      c = factorial((2 * i) + 1); //silnia
      result = result + ((a * b) / c);
      //difference
      diff = result - sin;
      diff = diff.abs();
      diffString = diff.toStringAsFixed(16);
      print("result $counter: $result | diff: $diffString");
      print('$result + ($a * $b) / $c');
      counter++;
    }
    return result;
  }
}
