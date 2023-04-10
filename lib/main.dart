import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_number_checker/flutter_number_checker.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Shapes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: const NumberShapes(),
      ),
    );
  }
}

class NumberShapes extends StatefulWidget {
  const NumberShapes({super.key});

  @override
  State<NumberShapes> createState() => _NumberShapesState();
}

class _NumberShapesState extends State<NumberShapes> {
  final TextEditingController _textController = TextEditingController();

  bool _isError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Shapes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Please input a number to see if it is square or cube.',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  errorText: _isError ? 'Please enter a valid number' : null,
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                keyboardType: TextInputType.number,
                onChanged: (String value) {
                  setState(
                    () {
                      _isError = false;
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final int? inputNumber = int.tryParse(_textController.text);
          if (inputNumber == null) {
            setState(() {
              _isError = true;
            });
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(inputNumber.toString()),
                  content: Text('Number $inputNumber is ${_getNumberState(inputNumber)}.'),
                );
              },
            );
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}

String _getNumberState(int number) {
  final bool numberIsSquare = number.toDouble().isPerfectSquare;
  final bool numberIsCube = number.toDouble().isPerfectCube;

  if (numberIsSquare && numberIsCube) {
    return 'both SQUARE and CUBE';
  } else if (numberIsSquare) {
    return 'SQUARE';
  } else if (numberIsCube) {
    return 'CUBE';
  } else {
    return 'neither SQUARE nor CUBE';
  }
}
