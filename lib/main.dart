import 'package:currency_convertor/currencies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  String? errorText; // value that contains the current error if appropriate

  CurrencyData currencyData = CURRENCIES_DATA[0];

  List<DropdownMenuItem<CurrencyData>> getCurrenciesMenuItems() {
    List<DropdownMenuItem<CurrencyData>> result = [];

    for (var element in CURRENCIES_DATA) {
      result.add(DropdownMenuItem(value: element, child: Text(element.name)));
    }

    //return CURRENCIES_DATA.map((CurrencyData element) => DropdownMenuItem(value: element, child: Text(element.name)));

    return result;
  }

  void currecyChaged() {
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
      valueConverted = valueReceived! * currencyData.ronConvertion;
      errorText = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          DropdownButton(
            value: currencyData,
            hint: const Text('Select'),
            onChanged: (CurrencyData? value) {
              if (value == null) {
                return;
              }

              setState(() {
                // setting the selected currency
                currencyData = value;
                currecyChaged();
              });
            },
            items: getCurrenciesMenuItems(),
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
                  currencyData.assetPath,
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
                  currecyChaged();
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
