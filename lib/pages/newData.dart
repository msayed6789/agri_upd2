


import 'package:agri_upd2/pages/dataList.dart';
import 'package:agri_upd2/shared/colors_constants.dart';
import 'package:agri_upd2/shared/sharing.dart';
import 'package:agri_upd2/shared/snakbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';

const List<String> list = <String>['Male', 'Female'];

String gender = "Male";

DateTime date_Setted = DateTime.now();


class Newdata extends StatefulWidget {
  const Newdata({super.key});

  @override
  State<Newdata> createState() => _NewdataState();
}

class _NewdataState extends State<Newdata> {
  final date_Setted = TextEditingController();
  final hisNumdata = TextEditingController();
  final faNumdata = TextEditingController();
  final moNumdata = TextEditingController();
  final spec = TextEditingController();
  final weight = TextEditingController();

  bool fireBaseSaveFirstTime = true;

  void _selectDate() async {
    print(DateTime.now());
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2500),
    );

    if (picked != null) {
      setState(() {
        date_Setted.text = picked.toString();
      });
    }
  }

  CollectionReference sheap = FirebaseFirestore.instance.collection('Sheap');

  void saveDataFirebase() async {
    if (await ConnectivityWrapper.instance.isConnected == true) {
      sheap
          .doc(allData[((allData.length) - 1)].fireSaveNum)
          .set({
            'hisNum': allData[(allData.length) - 1].hisNum,
            'faNum': allData[(allData.length) - 1].faNum,
            'moNum': allData[(allData.length) - 1].moNum,
            'spec': allData[(allData.length) - 1].spec,
            'gender': allData[(allData.length) - 1].gender,
            'birthday': (allData[(allData.length) - 1].birthday).toString(),
            'weight': allData[(allData.length) - 1].weights,
            'weightsTime': allData[(allData.length) - 1].weightsTime,
            'fireSaveNum': allData[(allData.length) - 1].fireSaveNum
          })
          .then((value) => showSnackBar(context, "The Data is Added"))
          .catchError((error) => fireBaseSaveFirstTime = false);
    } else {
      fireBaseSaveFirstTime = false;
      print("No");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BTNgreen,
        title: Text(
          "New Data",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(22, 30, 22, 0),
              child: TextField(
                controller: hisNumdata,
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
                controller: faNumdata,
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
                controller: moNumdata,
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
                controller: spec,
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
                  controller: date_Setted,
                ),
              ),
            ]),
            Padding(
              padding: EdgeInsets.fromLTRB(50, 30, 50, 0),
              child: TextField(
                controller: weight,
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
                          if (date_Setted.text != "" &&
                              hisNumdata.text != "" &&
                              faNumdata.text != "" &&
                              moNumdata.text != "" &&
                              spec.text != "" &&
                              weight.text != "") {
                            //  DateFormat format = DateFormat("yyy-MM-dd");
                            //DateFormat format = DateFormat("yMd");
                            DateTime dateTime =
                                DateTime.parse((date_Setted.text));

                            allData.add(DataStored(
                              hisNum: hisNumdata.text,
                              faNum: faNumdata.text,
                              moNum: moNumdata.text,
                              spec: spec.text,
                              gender: gender,
                              birthday: dateTime,
                            ));

                            (allData[(allData.length) - 1].weightsTime)
                                .add(dateTime.toString());

                            allData[(allData.length) - 1].fireSaveNum =
                                ((allData.length) - 1).toString();

                            (allData[(allData.length) - 1].weights)
                                .add(double.parse(weight.text));

                            saveDataFirebase();
                            if (fireBaseSaveFirstTime == true) {
                              print("hhh");
                              /*
                              WorkManagerService.registerMyTask(
                                  allData[(allData.length) - 1].fireSaveNum,
                                  allData[(allData.length) - 1].fireSaveNum,
                                  //  Duration(days: 1));
                                  Duration(minutes: 1));
*/
/*
                              NotificationService.createNotifi(
                                  int.parse(allData[(allData.length) - 1]
                                      .fireSaveNum),
                                  "Take the Weight",
                                  "Set the new weight for the sample No. ${allData[(allData.length) - 1].hisNum}",
                                  "Take the Weight Set the new weight for the sample No. ${allData[(allData.length) - 1].hisNum}");
                                  */
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Datalist()),
                              );

                              //print("Done");
                            } else {
                              allData.removeLast();
                              fireBaseSaveFirstTime = true;
                            }
                          } else {
                            showSnackBar(context, "Something Error");
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
            )
          ],
        ),
      ),
    );
  }
}