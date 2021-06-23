import 'dart:convert';

import 'package:ds_session_2/RecordComponents/recordComponents.dart';
import 'package:ds_session_2/model/state_model.dart';
import 'package:ds_session_2/screen/countriesList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WorldCovidCases extends StatefulWidget {
  _WorldCovidCasesState createState() => _WorldCovidCasesState();
}

class _WorldCovidCasesState extends State<WorldCovidCases> {
  Future<Record_Model?> getRecordModel() async {
    var response = await http.get(
      Uri.parse('https://disease.sh/v3/covid-19/all'),
    );
    var data = jsonDecode(response.body);
    print('console data... $data');
    if (response.statusCode == 200) {
      return Record_Model.fromJson(data);
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'World State',
              style: TextStyle(
                fontSize: 30.0,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            FutureBuilder<Record_Model?>(
              future: getRecordModel(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            componentRecord(
                              title: 'cases',
                              value: snapshot.data!.cases.toString(),
                            ),
                            componentRecord(
                                title: 'Active cases',
                                value: snapshot.data!.active.toString()),
                            componentRecord(
                                title: 'death',
                                value: snapshot.data!.deaths.toString()),
                            componentRecord(
                                title: 'today cases',
                                value: snapshot.data!.todayCases.toString()),
                            componentRecord(
                                title: 'today deaths',
                                value: snapshot.data!.todayDeaths.toString()),
                            componentRecord(
                                title: 'Recovered Cases',
                                value: snapshot.data!.recovered.toString()),
                            componentRecord(
                                title: 'critical',
                                value: snapshot.data!.critical.toString()),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CountryListScreen(),
                  ),
                );
              },
              child: Container(
                width: 200,
                height: 40,
                color: Colors.green,
                child: Center(
                  child: Text(
                    'Countries Tracker',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
