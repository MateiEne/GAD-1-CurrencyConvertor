import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const EURO_CURRENCY = 4.5;
double valueReceived = 0;
double valueConverted = 0;

final GlobalKey<FormState> formkey = GlobalKey<FormState>();

void main() {
  runApp(const CurrencyConvertorApp());
}

class CurrencyConvertorApp extends StatelessWidget {
  const CurrencyConvertorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  final double EURO_CURRENCY = 4.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  'assets/cash-ron.png',
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
            ElevatedButton(
              onPressed: () {
                setState(() {
                  value = double.parse(controller.text);
                  value = value * EURO_CURRENCY;
                });
                print(value.toStringAsFixed(2));
              },
              child: const Text('Convert!'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
              ),
            ),
            Text('$value'),
          ],
        ),
      ),
    );
  }
}
