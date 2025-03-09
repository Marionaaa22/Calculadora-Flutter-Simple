import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String _output = "0";
  String _input = "";
  double _num1 = 0;
  double _num2 = 0;
  String _operation = "";
  bool _isResultDisplayed = false;

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _input = "";
        _num1 = 0;
        _num2 = 0;
        _operation = "";
        _isResultDisplayed = false;
      } else if (buttonText == "+" || buttonText == "-" || buttonText == "x" || buttonText == "/") {
        _num1 = double.parse(_input);
        _operation = buttonText;
        _input = "";
        _output = _num1.toString() + " " + _operation;
        _isResultDisplayed = false;
      } else if (buttonText == "=") {
        _num2 = double.parse(_input);

        switch (_operation) {
          case "+":
            _output = (_num1 + _num2).toString();
            break;
          case "-":
            _output = (_num1 - _num2).toString();
            break;
          case "x":
            _output = (_num1 * _num2).toString();
            break;
          case "/":
            _output = (_num1 / _num2).toString();
            break;
        }

        _num1 = 0;
        _num2 = 0;
        _operation = "";
        _input = _output;
        _isResultDisplayed = true;
      } else {
        if (_isResultDisplayed) {
          _input = buttonText;
          _output = _input;
          _isResultDisplayed = false;
        } else {
          _input += buttonText;
          if (_operation.isNotEmpty) {
            _output = _num1.toString() + " " + _operation + " " + _input;
          } else {
            _output = _input;
          }
        }
      }
    });
  }

  Widget _buildButton(String buttonText) {
    Color buttonColor;
    if (buttonText == "/" || buttonText == "x" || buttonText == "-" || buttonText == "+") {
      buttonColor = Colors.white;
    } else if (buttonText == "=" || buttonText == "C") {
      buttonColor = Colors.red;
    } else {
      buttonColor = Color.fromARGB(255, 255, 178, 55);
    }

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0), // Menos padding para botones más grandes
        child: ElevatedButton(
          onPressed: () => _buttonPressed(buttonText),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(20),
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // Bordes redondeados
            ),
            elevation: 5, // Agregar sombra para darle más estilo
          ),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 0, 0), fontFamily: "Robot"), // Aumentar el tamaño del texto
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(91, 229, 118, 1), // Color de fondo de la calculadora
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(91, 229, 118, 1), // Color de la barra superior
        elevation: 0, // Eliminar la sombra de la appbar
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            color: Color.fromARGB(255, 224, 229, 232), // Color de fondo de la pantalla
            child: Text(
              _output,
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: "Robot"), // Cambiar la fuente del texto
            ),
          ),
          Divider(
            thickness: 2,
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    _buildButton("7"),
                    _buildButton("8"),
                    _buildButton("9"),
                    _buildButton("/"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton("4"),
                    _buildButton("5"),
                    _buildButton("6"),
                    _buildButton("x"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton("1"),
                    _buildButton("2"),
                    _buildButton("3"),
                    _buildButton("-"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton("C"),
                    _buildButton("0"),
                    _buildButton("="),
                    _buildButton("+"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}