import 'package:covid_communiquer/model/api_model.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:covid_communiquer/api_connection/api_connection.dart';

class SimpleLineChart extends StatefulWidget {
  State<SimpleLineChart> createState() => _SimpleLineChart();
}

class _SimpleLineChart extends State<SimpleLineChart> {
  List<charts.Series<GraphParamsNumbers, int>> _seriesList;
  List<charts.Series<Sales, int>> _seriesLineData;

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
  List<GraphParams> gp;

  @override
  void initState() {
    super.initState();
    _seriesList = List<charts.Series<GraphParamsNumbers, int>>();
    _seriesLineData = List<charts.Series<Sales, int>>();
    _callThatFunction();
  }

  _callThatFunction() async {
    gp = await getGraphParams(_state);
    await _graphData(gp);
  }

  _graphData(List<GraphParams> gp) {
    var data = List<GraphParamsNumbers>();
    int i = 0;
    for (GraphParams param in gp) {
      print(param.date + " : " + param.deaths.toString());
      data.add(new GraphParamsNumbers(i, param.deaths));
      i++;
    }
    _seriesList.clear();
    _seriesList.add(charts.Series(
        data: data,
        domainFn: (GraphParamsNumbers grp, _) => grp.number,
        measureFn: (GraphParamsNumbers grp, _) => grp.deaths,
        colorFn: (GraphParamsNumbers grp, _) =>
            charts.ColorUtil.fromDartColor(Colors.deepPurple),
        id: "COVID 19 DATA"));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
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
              onChanged: (String value) async {
                gp = await getGraphParams(value);
                setState(() {
                  this._state = value;
                });
                await _graphData(gp);
              },
            ),
          ),
        ),
      ),
      SizedBox(
        height: 10.0,
      ),
      Expanded(
          child: charts.LineChart(
        _seriesList,
        defaultRenderer:
            new charts.LineRendererConfig(includeArea: true, stacked: true),
        animate: true,
      ))
    ]);
  }
}

class GraphParamsNumbers {
  int number;
  int deaths;

  GraphParamsNumbers(this.number, this.deaths);
}

class Sales {
  int yearval;
  int salesval;

  Sales(this.yearval, this.salesval);
}
