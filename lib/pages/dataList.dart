


import 'dart:io';

import 'package:agri_upd2/pages/cardInfo.dart';
import 'package:agri_upd2/pages/newData.dart';
import 'package:agri_upd2/shared/card.dart';
import 'package:agri_upd2/shared/colors_constants.dart';
import 'package:agri_upd2/shared/sharing.dart';
import 'package:agri_upd2/shared/snakbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Datalist extends StatefulWidget {
  const Datalist({super.key});

  @override
  State<Datalist> createState() => _DatalistState();
}

class _DatalistState extends State<Datalist> {

  CollectionReference sheap = FirebaseFirestore.instance.collection('Sheap');

  void deleteCard(int index) async {
    setState(() {
      sheap.doc(allData[index].fireSaveNum).delete();
      allData.removeAt(index);
    });
  }

  String nextCharacter(String char) {
    int nextCharCode = char.codeUnitAt(0) + 1;
    return String.fromCharCode(nextCharCode);
  }



  void createExcel() async {
    int weightListLength = 0;
    int loobIndex = 0;
    int loobSecondIndex = 0;
    int cellNum = 1;
    int dataListLength = 0;

    // Step 1: Request permissions
    if (await Permission.storage.request().isGranted) {
      // Step 2: Create an Excel object
      var excel = Excel.createExcel();
      Sheet sheet = excel['Sheet1']; // Create a default sheet

      sheet.appendRow([
        TextCellValue('His Number'),
        TextCellValue('Father Name'),
        TextCellValue('Mother Name'),
        TextCellValue('Specifications'),
        TextCellValue('Gender'),
        TextCellValue('DOB'),
        TextCellValue('WOB'),
      ]);

      weightListLength = allData[0].weights.length;
      String charEnd = 'G';
      String nextChar = nextCharacter(charEnd);
      for (loobIndex = 0; loobIndex < weightListLength - 1; loobIndex++) {
        var cell = sheet.cell(CellIndex.indexByString('$nextChar 1'));
        if (loobIndex < 1) {
          cell.value = TextCellValue('After 15 Days');
        } else {
          cell.value = TextCellValue('After $loobIndex Month');
        }
        nextChar = nextCharacter(nextChar);
      }

      dataListLength = allData.length;
      charEnd = 'F';
      nextChar = nextCharacter(charEnd);
      for (loobIndex = 0; loobIndex < dataListLength; loobIndex++) {
        sheet.appendRow([
          TextCellValue(allData[loobIndex].hisNum),
          TextCellValue(allData[loobIndex].faNum),
          TextCellValue(allData[loobIndex].moNum),
          TextCellValue(allData[loobIndex].spec),
          TextCellValue(allData[loobIndex].gender),
          TextCellValue((allData[loobIndex].birthday).toString()),
        ]);
        weightListLength = (allData[loobIndex].weights).length;
        for (loobSecondIndex = 0;
            loobSecondIndex < weightListLength;
            loobSecondIndex++) {
          var cell = sheet.cell(CellIndex.indexByString('$nextChar $cellNum'));
          cell.value =
              DoubleCellValue(allData[loobIndex].weights[loobSecondIndex]);
          nextChar = nextCharacter(nextChar);
        }
        cellNum++;
        charEnd = 'F';
        nextChar = nextCharacter(charEnd);
      }
      // Step 4: Save the file
      try {
        // Get the directory for saving the file
        Directory downloadsDir = Directory('/storage/emulated/0/Download');
        //final Directory downloadsDir = await getTemporaryDirectory();
        String filePath = '${downloadsDir.path}/example.xlsx';
        print(downloadsDir.path);

        // Write the Excel file
        File(filePath)
          ..createSync(recursive: true)
          ..writeAsBytesSync(excel.encode()!)
          ..writeAsBytesSync(excel.save()!);

        showSnackBar(context, "The Excel File was saved successfully");
      } catch (e) {
        showSnackBar(context, "Failed to save file");
      }
    } else {
      showSnackBar(context, "Storage permission denied");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Newdata()),
              );
            });
          },
          child: Icon(
            Icons.add,
            color: Colors.black,
            size: 30,
          ),
          backgroundColor: BTNgreen,
        ),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    createExcel();
                  });
                },
                icon: Icon(
                  Icons.file_copy_sharp,
                  size: 35,
                  color: Colors.black,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
/******** */
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: FractionallySizedBox(
                              widthFactor: 0.9,
                              heightFactor: 0.3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(11)),
                                      child: Text(
                                        "Are you sure you want to permanently delete all data",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          for (int index = 0;
                                              index < allData.length;
                                              index++) {
                                            sheap
                                                .doc(allData[index].fireSaveNum)
                                                .delete();
                                          }
                                          allData.clear();
                                          showSnackBar(context,
                                              "All data has been successfully deleted");
                                          Navigator.pop(context);
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  BTNgreen),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadiusDirectional
                                                          .circular(25))),
                                        ),
                                        child: Text(
                                          "Yes",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  BTNgreen),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadiusDirectional
                                                          .circular(25))),
                                        ),
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                    /******** */
                  });
                },
                icon: Icon(
                  Icons.delete_forever,
                  size: 35,
                  color: Colors.black,
                ))
          ],
          backgroundColor: BTNgreen,
          title: Text(
            "Data List",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: allData.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Cardinfo(index: index)),
                  );
                },
                child: CardF(
                  hisNumber: allData[index].hisNum,
                  birthday: allData[index].birthday,
                  status: allData[index].timeForWeight,
                  deleteCard: deleteCard,
                  index: index,
                ),
              );
            }));
  }
}