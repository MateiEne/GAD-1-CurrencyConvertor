import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const List<String> CURRENCY_IMAGES = [
  'assets/euro1.png',
  'assets/dollar.png',
  'assets/lire.png'
]; // a list with all the images used

const List<double> CURRENCY_VALUES = [
  4.5,
  4.28,
  5.78
]; // a list with all the currencies used

void main() {
  runApp(const CurrencyConvertorApp());
}

class CurrencyConvertorApp extends StatelessWidget {
  const CurrencyConvertorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController controller = TextEditingController();

  double? valueReceived = 0; // this is the value received from the user input
  double? valueConverted = 0; // this will be the value converted to the
  // respectively value received from the user input

  int index = 0; // index of the image that corresponds with the index of
  // currency values list

  String image = CURRENCY_IMAGES.elementAt(0); // current image

  String? errorText; // value that contains the current error if appropiate

  _HomePageState() {
    image = CURRENCY_IMAGES.elementAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          DropdownButton(
            value: index,
            hint: const Text('Select'),
            onChanged: (int? value) {
              if (value == null) {
                return;
              }
              setState(() {
                // setting the image that corresponds to the wanted convercy
                index = value;
                image = CURRENCY_IMAGES.elementAt(index);
              });
            },
            items: const <DropdownMenuItem<int>>[
              DropdownMenuItem<int>(
                value: 0,
                child: Text('euro'),
              ),
              DropdownMenuItem<int>(
                value: 1,
                child: Text('dolari'),
              ),
              DropdownMenuItem<int>(
                value: 2,
                child: Text('lire'),
              )
            ],
          )
        ],
        centerTitle: true,
        title: const Text(
          'Currency Convertor',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  image,
                  height: 200,
                ),
              ],
            ),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                errorText: errorText,
                hintText: 'Enter a number',
                suffix: IconButton(
                  onPressed: () {
                    controller.clear();
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  valueReceived = double.tryParse(controller.text);
                  // setting errors
                  if (controller.text.isEmpty) {
                    errorText = 'Please enter a number';
                    valueConverted = 0;
                  } else if (valueReceived == null) {
                    errorText = 'This is not a number';
                    valueConverted = 0;
                  } else {
                    // converting the received value
                    valueConverted =
                        valueReceived! * CURRENCY_VALUES.elementAt(index);
                    errorText = null;
                  }
                });
              },
              child: const Text('Convert!'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${valueConverted!.toStringAsFixed(2)} lei',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 30.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
