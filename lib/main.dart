import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          title: Center(
              child: Text('Currency Convertor')
          ),
        ),
        body: new Column(
          children: [
            Image.asset('assets/cash-ron.png'),
          ],
        ),
      ),
    );
  }
}
