
import 'package:agri_upd2/shared/colors_constants.dart';
import 'package:agri_upd2/shared/sharing.dart';
import 'package:agri_upd2/shared/tableTemplete.dart';
import 'package:flutter/material.dart';

bool firstTime = true;

class Weightsdata extends StatelessWidget {
final int index;
  const Weightsdata({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: BTNgreen,
          title: Text("Weights Data"),
        ),
        body: Padding(
            padding: EdgeInsets.only(top: 200),
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: ((allData[index].weights).length) + 1,
                itemBuilder: (BuildContext context, int index11) {
                  if (firstTime || index11 == 0) {
                    firstTime = false;
                    return Tabletemplete(
                      date: "Date",
                      weight: "Weight (Kg)",
                      isBold: true,
                      isBlack: true,
                      isHeader: true,
                      measurement: "No.DFB",
                    );
                  } else {
                    if (index11 - 1 == 0) {
                      return Tabletemplete(
                          date: allData[index].weightsTime[index11 - 1],
                          weight:
                              (allData[index].weights[index11 - 1]).toString(),
                          isBold: false,
                          isBlack: false,
                          isHeader: false,
                          measurement: "DOB");
                    } else if (index11 - 1 == 1) {
                      return Tabletemplete(
                          date: allData[index].weightsTime[index11 - 1],
                          weight:
                              (allData[index].weights[index11 - 1]).toString(),
                          isBold: false,
                          isBlack: false,
                          isHeader: false,
                          measurement: "After 15 Days");
                    }
                    
                    else {
                      return Tabletemplete(
                          date: allData[index].weightsTime[index11 - 1],
                          weight:
                              (allData[index].weights[index11 - 1]).toString(),
                          isBold: false,
                          isBlack: false,
                          isHeader: false,
                          measurement: "After ${index11-2} month");
                    }
                  }
                })));
  }
}