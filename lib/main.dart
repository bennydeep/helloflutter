import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bennys Calc',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "FFMI calc",
                ),
                Tab(text: "Macro calc"),
                Tab(text: "BF% calc"),
              ],
            ),
            title: Text('Hello World'),
          ),
          body: TabBarView(
            children: [
              MyHomePage(),
              MacroCalc(),
              EstimatedBodyfat(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController num1controller = new TextEditingController();
  TextEditingController num2controller = new TextEditingController();
  TextEditingController num3controller = new TextEditingController();
  String text = "";
  String ffmi = "0";
  String result = "0";
  String natty = "";

  void changeText(text) {
    this.setState(() {
      this.text = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
      TextField(
        decoration: InputDecoration(
            labelText: "  Height", prefixText: "  ", suffixText: "cm  "),
        keyboardType: TextInputType.number,
        controller: num1controller,
      ),
      TextField(
        decoration: InputDecoration(
            labelText: "  BodyWeight", prefixText: "  ", suffixText: "kg  "),
        keyboardType: TextInputType.number,
        controller: num2controller,
      ),
      TextField(
        decoration: InputDecoration(
            labelText: "  BodyFat%", prefixText: "  ", suffixText: "%  "),
        keyboardType: TextInputType.number,
        controller: num3controller,
      ),
      IconButton(
        icon: Icon(Icons.send),
        splashColor: Colors.blue,
        onPressed: () {
          setState(() {
            double m = int.parse(num1controller.text) / 100;
            double szazalek = int.parse(num3controller.text) / 100;
            double egyminusz = 1 - szazalek;
            double fatfree = int.parse(num2controller.text) * egyminusz;
            double ffmi = fatfree / (m * m);
            if (ffmi <= 18) {
              natty = "Below Average";
            } else if (ffmi < 20 && ffmi >= 18) {
              natty = "Average";
            } else if (ffmi < 22 && ffmi >= 20) {
              natty = "Above average";
            } else if (ffmi < 25 && ffmi >= 22) {
              natty = "Excellent";
            } else {
              natty = "Probably Steroid";
            }
            result = ffmi.toStringAsFixed(2);
          });
        },
      ),
      Text(""),
      Text("FFMI"),
      Text(""),
      Text(result),
      Text(""),
      Text(natty)
    ]));
  }
}

class MacroCalc extends StatefulWidget {
  @override
  _MacroCalcState createState() => _MacroCalcState();
}

class _MacroCalcState extends State<MacroCalc> {
  TextEditingController num1controller = new TextEditingController();
  String res1 = "";
  String res2 = "";
  String res3 = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
      TextField(
        decoration: InputDecoration(
            labelText: "  I want to eat this much",
            prefixText: "  ",
            suffixText: "kcal  "),
        keyboardType: TextInputType.number,
        controller: num1controller,
      ),
      IconButton(
        icon: Icon(Icons.send),
        splashColor: Colors.blue,
        onPressed: () {
          setState(() {
            double ch = (int.parse(num1controller.text) * 0.5) / 4;
            double protein = (int.parse(num1controller.text) * 0.17) / 4;
            double fat = (int.parse(num1controller.text) * 0.33) / 9;
            res1 = ch.toStringAsFixed(2);
            res2 = protein.toStringAsFixed(2);
            res3 = fat.toStringAsFixed(2);
          });
        },
      ),
      Text(""),
      Text("Carbohydrates: " + res1 + " g"),
      Text(""),
      Text("Proteins: " + res2 + " g"),
      Text(""),
      Text("Fats: " + res3 + " g")
    ]));
  }
}

class EstimatedBodyfat extends StatefulWidget {
  @override
  _EstimatedBodyfatState createState() => _EstimatedBodyfatState();
}

class _EstimatedBodyfatState extends State<EstimatedBodyfat> {
  TextEditingController num1controller = new TextEditingController();
  TextEditingController num2controller = new TextEditingController();
  TextEditingController num3controller = new TextEditingController();
  TextEditingController num4controller = new TextEditingController();
  String res1 = "";
  String res2 = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
      TextField(
        decoration: InputDecoration(
            labelText: "  Sex", prefixText: "  ", suffixText: "0 - M, 1 - F  "),
        keyboardType: TextInputType.number,
        controller: num1controller,
      ),
      TextField(
        decoration: InputDecoration(
            labelText: "  Age", prefixText: "  ", suffixText: "year  "),
        keyboardType: TextInputType.number,
        controller: num2controller,
      ),
      TextField(
        decoration: InputDecoration(
            labelText: "  Height", prefixText: "  ", suffixText: "cm  "),
        keyboardType: TextInputType.number,
        controller: num3controller,
      ),
      TextField(
        decoration: InputDecoration(
            labelText: "  BodyWeight", prefixText: "  ", suffixText: "kg  "),
        keyboardType: TextInputType.number,
        controller: num4controller,
      ),
      IconButton(
        icon: Icon(Icons.send),
        splashColor: Colors.blue,
        onPressed: () {
          setState(() {
            int sex = int.parse(num1controller.text);
            int age = int.parse(num2controller.text);
            double m = double.parse(num3controller.text) / 100;
            double kg = double.parse(num4controller.text);
            double bmi = kg / (m * m);
            double bf = -44.988 +
                (0.503 * age) +
                (10.689 * sex) +
                (3.172 * bmi) -
                (0.026 * bmi * bmi) +
                (0.181 * bmi * sex) -
                (0.02 * bmi * age) -
                (0.005 * bmi * bmi * sex) +
                (0.00021 * bmi * bmi * age);
            res1 = bmi.toStringAsFixed(2);
            res2 = bf.toStringAsFixed(2);
          });
        },
      ),
      Text(""),
      Text("BMI"),
      Text(res1),
      Text(""),
      Text("Estimated BodyFat "),
      Text(res2 + " %")
    ]));
  }
}

class TextInputWidget extends StatefulWidget {
  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  final controller = TextEditingController();
  String text = "";
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void click() {}

  void changeText(text) {
    setState(() {
      this.text = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      TextField(
        controller: this.controller,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.message), labelText: "BodyWeight"),
        onChanged: (text) => this.changeText(text),
      ),
    ]);
  }
}

class TextInputWidget2 extends StatefulWidget {
  @override
  _TextInputWidget2State createState() => _TextInputWidget2State();
}

class _TextInputWidget2State extends State<TextInputWidget2> {
  final controller2 = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller2.dispose();
  }

  void click() {}

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      TextField(
        controller: this.controller2,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.message), labelText: "BodyFat%"),
      ),
    ]);
  }
}
