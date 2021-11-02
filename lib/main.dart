import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const EURO_CURRENCY = 4.5;
double value = 0;

void main() {
  runApp(const CurrencyConvertorApp());
}

class CurrencyConvertorApp extends StatelessWidget {
   const CurrencyConvertorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Center(
              child: Text('Currency Convertor')
          ),
        ),
        body: Column(
          children: <Widget>[
            Image.asset('assets/cash-ron.png'),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Enter the amount in EUR',
              ),
              keyboardType: TextInputType.number,
              onChanged: (String text) {
                value = double.parse(text);
              },
              onSubmitted: (text) {
                value = value * EURO_CURRENCY;
                print(value);
              },
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
                  onPressed: () {
                    value = value * EURO_CURRENCY;
                    print(value);
                  },
                child: const Text('Convert'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
