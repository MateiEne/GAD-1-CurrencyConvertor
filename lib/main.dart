import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const EURO_CURRENCY = 4.5;
const List<String> CURRENCY_IMAGES = [
  'assets/euro1.png',
  'assets/dollar.png',
  'assets/lire.png'
];
const List<double> CURRENCY_VALUES = [4.5, 4.28, 5.78];

final GlobalKey<FormState> formkey = GlobalKey<FormState>();

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

  double value = 0;

  int index = 0;
  String image = CURRENCY_IMAGES.elementAt(0);

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
                hintText: 'Enter a number',
                suffix: IconButton(
                  onPressed: () {
                    controller.clear();
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    value = double.parse(controller.text);
                    value = value * CURRENCY_VALUES.elementAt(index);
                  });
                  print(value.toStringAsFixed(2));
                },
                child: const Text('Convert!'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '$value lei',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 35.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
