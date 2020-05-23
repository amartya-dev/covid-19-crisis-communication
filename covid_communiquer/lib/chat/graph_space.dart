import 'package:flutter/material.dart';
import 'dart:async';
import 'package:charts_flutter/flutter.dart' as charts;


class SimpleLineChart extends StatefulWidget {
  State<SimpleLineChart> createState() => _SimpleLineChart();
}

class _SimpleLineChart extends State<SimpleLineChart> {
  List<charts.Series> seriesList;
  static const STATE_DROPDOWN_MENU_ITEMS = [
    DropdownMenuItem(
        value: "Andhra Pradesh", child: const Text("Andhra Pradesh")),
    DropdownMenuItem(
        value: "Arunachal Pradesh ", child: const Text("Arunachal Pradesh ")),
    DropdownMenuItem(value: "Assam", child: const Text("Assam")),
    DropdownMenuItem(value: "Bihar", child: const Text("Bihar")),
    DropdownMenuItem(value: "Chhattisgarh", child: const Text("Chhattisgarh")),
    DropdownMenuItem(value: "Goa", child: const Text("Goa")),
    DropdownMenuItem(value: "Gujarat", child: const Text("Gujarat")),
    DropdownMenuItem(value: "Haryana", child: const Text("Haryana")),
    DropdownMenuItem(
        value: "Himachal Pradesh", child: const Text("Himachal Pradesh")),
    DropdownMenuItem(
        value: "Jammu and Kashmir ", child: const Text("Jammu and Kashmir ")),
    DropdownMenuItem(value: "Jharkhand", child: const Text("Jharkhand")),
    DropdownMenuItem(value: "Karnataka", child: const Text("Karnataka")),
    DropdownMenuItem(value: "Kerala", child: const Text("Kerala")),
    DropdownMenuItem(
        value: "Madhya Pradesh", child: const Text("Madhya Pradesh")),
    DropdownMenuItem(value: "Maharashtra", child: const Text("Maharashtra")),
    DropdownMenuItem(value: "Manipur", child: const Text("Manipur")),
    DropdownMenuItem(value: "Meghalaya", child: const Text("Meghalaya")),
    DropdownMenuItem(value: "Mizoram", child: const Text("Mizoram")),
    DropdownMenuItem(value: "Nagaland", child: const Text("Nagaland")),
    DropdownMenuItem(value: "Odisha", child: const Text("Odisha")),
    DropdownMenuItem(value: "Punjab", child: const Text("Punjab")),
    DropdownMenuItem(value: "Rajasthan", child: const Text("Rajasthan")),
    DropdownMenuItem(value: "Sikkim", child: const Text("Sikkim")),
    DropdownMenuItem(value: "Tamil Nadu", child: const Text("Tamil Nadu")),
    DropdownMenuItem(value: "Telangana", child: const Text("Telangana")),
    DropdownMenuItem(value: "Tripura", child: const Text("Tripura")),
    DropdownMenuItem(
        value: "Uttar Pradesh", child: const Text("Uttar Pradesh")),
    DropdownMenuItem(value: "Uttarakhand", child: const Text("Uttarakhand")),
    DropdownMenuItem(value: "West Bengal", child: const Text("West Bengal")),
    DropdownMenuItem(
        value: "Andaman and Nicobar Islands",
        child: const Text("Andaman and Nicobar Islands")),
    DropdownMenuItem(value: "Chandigarh", child: const Text("Chandigarh")),
    DropdownMenuItem(
        value: "Dadra and Nagar Haveli",
        child: const Text("Dadra and Nagar Haveli")),
    DropdownMenuItem(
        value: "Daman and Diu", child: const Text("Daman and Diu")),
    DropdownMenuItem(value: "Lakshadweep", child: const Text("Lakshadweep")),
    DropdownMenuItem(
        value: "National Capital Territory of Delhi",
        child: const Text("National Capital Territory of Delhi")),
    DropdownMenuItem(value: "Puducherry", child: const Text("Puducherry")),
  ];

  var _state = "Karnataka";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(20),
          child: InputDecorator(
            decoration: InputDecoration(
              errorStyle: TextStyle(color: Colors.redAccent),
              icon: Icon(Icons.location_city),
              hintText: 'Select State',
              labelText: 'Select State',
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                items: STATE_DROPDOWN_MENU_ITEMS,
                value: _state,
                isDense: true,
                onChanged: (String value) {
                  _getNumbersOfThisState(value);
                  setState(() {
                    this._state = value;
                  });
                },
              ),
            ),
          ),
        )
    ]
    );
  }

//  Future<List<charts.Series<Deaths,int>>> _getNumbersOfThisState(String stateName) async{
//    await return [
//      new charts.Series<Deaths, int>(
//        id: 'Sales',
//        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
//        domainFn: (Deaths sales, _) => sales.year,
//        measureFn: (Deaths sales, _) => sales.sales,
//        data: data,
//      )
//    ];
//  }


//  final List<charts.Series> seriesList;
//  final bool animate;

//  SimpleLineChart(this.seriesList, {this.animate});
//
//  /// Creates a [LineChart] with sample data and no transition.
//  factory SimpleLineChart.withSampleData() {
//    return new SimpleLineChart(
//      _createSampleData(),
//      // Disable animations for image tests.
//      animate: false,
//    );
//  }
//
//
//  @override
//  Widget build(BuildContext context) {
//    return new charts.LineChart(seriesList, animate: animate);
//  }
//
//  /// Create one series with sample hard coded data.
//  static List<charts.Series<Deaths, int>> _createSampleData() {
//    final data = [
//      new Deaths(0, 5),
//      new Deaths(1, 25),
//      new Deaths(2, 100),
//      new Deaths(3, 75),
//    ];
//
//    return [
//      new charts.Series<Deaths, int>(
//        id: 'Sales',
//        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
//        domainFn: (Deaths sales, _) => sales.year,
//        measureFn: (Deaths sales, _) => sales.sales,
//        data: data,
//      )
//    ];
//  }
}


//class Deaths {
//  final int year;
//  final int sales;
//
//  Deaths(this.year, this.sales);
//}
