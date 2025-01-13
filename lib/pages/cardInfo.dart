


import 'package:agri_upd2/pages/dataList.dart';
import 'package:agri_upd2/pages/weightsData.dart';
import 'package:agri_upd2/shared/colors_constants.dart';
import 'package:agri_upd2/shared/sharing.dart';
import 'package:agri_upd2/shared/snakbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

const List<String> list = <String>['Male', 'Female'];

String gender = "Male";

class Cardinfo extends StatefulWidget {
  final int index;
  const Cardinfo({super.key, required this.index});

  @override
  State<Cardinfo> createState() => _CardinfoState(index: index);
}

class _CardinfoState extends State<Cardinfo> {
  final int index;
  _CardinfoState({required this.index});

  var dateSettedMod = TextEditingController();
  var hisNumdataMod = TextEditingController();
  var faNumdataMod = TextEditingController();
  var moNumdataMod = TextEditingController();
  var specMod = TextEditingController();
  var weightMod = TextEditingController();

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );

    if (picked != null) {
      setState(() {
        dateSettedMod.text = picked.toString();
      });
    }
  }

  @override
  void initState() {
    dateSettedMod.text = (allData[index].birthday).toString();
    hisNumdataMod.text = allData[index].hisNum;
    faNumdataMod.text = allData[index].faNum;
    moNumdataMod.text = allData[index].moNum;
    specMod.text = allData[index].spec;
    gender = allData[index].gender;
    super.initState();
  }

  CollectionReference sheap = FirebaseFirestore.instance.collection('Sheap');

  bool firebaseUpdateData = true;
  updateData() {
    DateTime dateTime = DateTime.parse(dateSettedMod.text);

    sheap
        .doc(allData[index].fireSaveNum)
        .update({
          'hisNum': allData[index].hisNum,
          'faNum': allData[index].faNum,
          'moNum': allData[index].moNum,
          'spec': allData[index].spec,
          'gender': allData[index].gender,
          'birthday': (allData[index].birthday).toString(),
          'weight': (allData[index].weights),
          'weightsTime': (allData[index].weightsTime),
        })
        .then((value) => showSnackBar(context, "Data is updated"))
        .catchError((error) => firebaseUpdateData = false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BTNgreen,
        title: Text(
          "Card Information",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(22, 30, 22, 0),
              child: TextField(
                controller: hisNumdataMod,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "His Number",
                  // To delete borders
                  enabledBorder: OutlineInputBorder(
                    borderSide: Divider.createBorderSide(context),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(8),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(22, 30, 22, 0),
              child: TextField(
                controller: faNumdataMod,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Father Number",
                  // To delete borders
                  enabledBorder: OutlineInputBorder(
                    borderSide: Divider.createBorderSide(context),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(8),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(22, 30, 22, 0),
              child: TextField(
                controller: moNumdataMod,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Mother Number",
                  // To delete borders
                  enabledBorder: OutlineInputBorder(
                    borderSide: Divider.createBorderSide(context),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(8),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(22, 30, 22, 10),
              child: TextField(
                controller: specMod,
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Specifications",
                  // To delete borders
                  enabledBorder: OutlineInputBorder(
                    borderSide: Divider.createBorderSide(context),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(8),
                ),
              ),
            ),
            Stack(children: [
              Positioned(
                right: 10,
                top: 20,
                child: DropdownMenu(
                  label: Text("Gender"),
                  leadingIcon: Icon(gender == "Male"
                      ? Icons.male_rounded
                      : Icons.female_sharp),
                  initialSelection: gender,
                  onSelected: (String? value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                  dropdownMenuEntries:
                      list.map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                        value: value, label: value);
                  }).toList(),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 232, 0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Date",
                    prefixIcon: Icon(Icons.calendar_today),
                    enabledBorder: OutlineInputBorder(
                      borderSide: Divider.createBorderSide(context),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    filled: false,
                  ),
                  readOnly: true,
                  onTap: () {
                    _selectDate();
                  },
                  controller: dateSettedMod,
                ),
              ),
            ]),
            Padding(
              padding: EdgeInsets.fromLTRB(50, 30, 50, 0),
              child: TextField(
                controller: weightMod,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Weight(Kg)",
                  // To delete borders
                  enabledBorder: OutlineInputBorder(
                    borderSide: Divider.createBorderSide(context),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(8),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 50, 22),
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (dateSettedMod.text != "" &&
                              hisNumdataMod.text != "" &&
                              faNumdataMod.text != "" &&
                              moNumdataMod.text != "" &&
                              specMod.text != "" &&
                              weightMod.text != "") {
                            DateTime dateTime =
                                DateTime.parse(dateSettedMod.text);

                            allData[index].hisNum = hisNumdataMod.text;
                            allData[index].faNum = faNumdataMod.text;
                            allData[index].moNum = moNumdataMod.text;
                            allData[index].spec = specMod.text;
                            allData[index].gender = gender;
                            //allData[index].birthday = dateTime;

                            (allData[index].weightsTime)
                                .add(dateTime.toString());

                            (allData[index].weights)
                                .add(double.parse(weightMod.text));

                            allData[index].timeForWeight = false;

                            updateData();
                            if (firebaseUpdateData == true) {
                              if ((allData[index].weights).length - 1 >= 3) {
                                // WorkManagerService.registerMyTask(
                                //     allData[index].toString(),
                                //     allData[index].toString(),
                                //     Duration(days: 2));
                              } else {
                                // WorkManagerService.registerMyTask(
                                //     allData[index].toString(),
                                //     allData[index].toString(),
                                //     Duration(days: 1));
                              }
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Datalist()),
                              );
                            }
                            else {
                            showSnackBar(context, "The Data Not updated");
                            firebaseUpdateData = true;
                          }
                          } 
                        });
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(BTNgreen),
                        padding: WidgetStateProperty.all(
                            EdgeInsets.fromLTRB(22, 0, 22, 0)),
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 22),
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Datalist()),
                          );
                        });
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(BTNgreen),
                        padding: WidgetStateProperty.all(
                            EdgeInsets.fromLTRB(10, 0, 10, 0)),
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                      )),
                ),
                
              ],

            ),
            Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 22),
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Weightsdata(index: index)),
                          );
                        });
                      },
                      child: Text(
                        "Weights List",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(BTNgreen),
                        padding: WidgetStateProperty.all(
                            EdgeInsets.fromLTRB(10, 0, 10, 0)),
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                      )),
                ),
          ],
        ),
      ),
    );
  }
}