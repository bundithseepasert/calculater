import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final double kmToMile = 0.621;
  final double mileToKM = 1.609;
  TextEditingController input = TextEditingController();
  double result = 0;
  DataType groupVal = DataType.KM;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homepage'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              TextField(
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ], 
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  /// if there are input
                  if (input.text.isNotEmpty) {
                    setState(() {
                      if (groupVal == DataType.KM) {
                        result = double.parse(input.text) * kmToMile;
                      } else {
                        result = double.parse(input.text) * mileToKM;
                      }
                    });
                  } else {
                    setState(() {
                      input.clear();
                      result = 0;
                    });
                  }
                },
                controller: input,
                decoration: InputDecoration(
                    hintText: groupVal == DataType.KM
                        ? 'Please enter KM'
                        : 'Please enter Mile'),
              ),
              SizedBox(
                height: 15,
              ),
              RadioListTile(
                  title: Text('KM'),
                  value: DataType.KM,
                  groupValue: groupVal,
                  onChanged: (val) {
                    setState(() {
                      groupVal = DataType.KM;
                      input.clear();
                      result = 0;
                    });
                  }),
              RadioListTile(
                  title: Text('Mile'),
                  value: DataType.Mile,
                  groupValue: groupVal,
                  onChanged: (val) {
                    setState(() {
                      groupVal = DataType.Mile;
                      input.clear();
                      result = 0;
                    });
                  }),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '${result == 0.0 ? '' : '${input.text} ${groupVal == DataType.KM ? 'KM' : 'Miles'} is ${result.toStringAsFixed(2)} ${groupVal == DataType.KM ? 'Miles' : 'KM'}'}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
      ),
    );
  }
}

enum DataType { KM, Mile }