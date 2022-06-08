import 'package:flutter/material.dart';
import 'package:global_fitness/shared/menu_bottom.dart';
import 'package:global_fitness/shared/menu_drawer.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({Key? key}) : super(key: key);

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  final TextEditingController txtHeight = TextEditingController();
  final TextEditingController txtWeight = TextEditingController();
  final double fontSize = 18;
  String result = '';
  bool isMetric = true;
  bool isImperial = false;
  bool isOther = false;
  double? height;
  double? weight;
  late List<bool> isSelected;
  String heightMessage = '';
  String weightMessage = '';

  @override
  void initState() {
    super.initState();
    isSelected = [
      // 0
      isMetric,
      // 1
      isImperial
    ];

  }
  @override
  Widget build(BuildContext context) {
    heightMessage = 'Please put in your height in ' + ((isMetric)? 'meters' : 'inches');
    weightMessage = 'Please put in your weight in ' + ((isMetric)? 'kg' : 'lb');
    return Scaffold(
        appBar: AppBar(title: const Text('BMI Calculator')),
        bottomNavigationBar: MenuBottom(context),
        drawer: const MenuDrawer(),
        body: SingleChildScrollView(
          child: Column(
              children: [
                ToggleButtons(
                  children: const [
                    // 0 - isMetric
                    Padding(padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('Metric', style: TextStyle(fontSize: 18)),
                    ),
                    // 1 - isImperial
                    Padding(padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('Imperial', style: TextStyle(fontSize: 18)),
                    ),
                  ],
                  isSelected: isSelected,
                  onPressed: (value) {
                    print(value);
                    toggleMeasure(value);


                  }
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: TextField(controller: txtHeight, keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: heightMessage
                    ),
                  ),
                ),
                Padding(
                  padding:  const EdgeInsets.all(32.0),
                  child: TextField(controller: txtWeight, keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: weightMessage
                      ),
                  ),
                ),
                ElevatedButton(
                  child: Text('Calculate ',
                  style: TextStyle(
                    fontSize: fontSize
                  )),
                  onPressed: findBMI,
                ),
                Text(result,
                style: TextStyle(
                  fontSize: fontSize
                ))
              ]
          ),
        ),
    );
  }

  void toggleMeasure(value) {
    if (value == 0) {
      isMetric = true;
      isImperial = false;
      isOther = false;
    } else if (value == 1) {
      isMetric = false;
      isImperial = true;
      isOther = false;
    }
    setState(() {
      isSelected = [isMetric, isImperial];
    });
  }
  void findBMI() {
    double bmi = 0;
    double height = double.tryParse(txtHeight.text) ?? 0;
    double weight = double.tryParse(txtWeight.text) ?? 0;
    if (isMetric) {
      bmi = weight / (height * height);
    }
    else {
      bmi = weight * 703 / (height * height);
    }
    setState(() {
      result = 'Your BMI is ' + bmi.toStringAsFixed(2);
    });


  }
}
