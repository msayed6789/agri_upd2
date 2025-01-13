


import 'package:agri_upd2/shared/colors_constants.dart';
import 'package:flutter/material.dart';

class Tabletemplete extends StatelessWidget {
  final String date;
  final String weight;
  final String measurement;
  final bool isBold;
  final bool isBlack;
  final bool isHeader;
  const Tabletemplete({super.key, required this.date, required this.weight, required this.isBold,required this.isBlack,required this.isHeader,required this.measurement});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(width :2),
      children: [
        TableRow(decoration: BoxDecoration(color: BTNgreen), children: [
          TableCell(
            verticalAlignment:TableCellVerticalAlignment.middle,
            child: SizedBox(
              height: 32,
              width: double.infinity,
              child: Text(
                date,
                style: TextStyle(fontSize: 20, fontWeight: isBold? FontWeight.bold:FontWeight.normal,color: isBlack?Colors.black:Colors.white),
              ),
            ),
          ),
          TableCell(
            child: SizedBox(
              height: 32,
              width: double.infinity,
              child: Text(weight,style: TextStyle(fontSize: 20, fontWeight: isBold? FontWeight.bold:FontWeight.normal,color: isBlack?Colors.black:Colors.white),),
            ),
          ),
          TableCell(
            child: SizedBox(
              height: 32,
              width: double.infinity,
              child: Text(measurement,style: TextStyle(fontSize: 20, fontWeight: isBold? FontWeight.bold:FontWeight.normal,color: isBlack?Colors.black:Colors.white),),
            ),
          ),
        ])
      ],
    );
  }
}