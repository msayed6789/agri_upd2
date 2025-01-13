


import 'dart:async';

import 'package:agri_upd2/pages/dataList.dart';
import 'package:agri_upd2/pages/newData.dart';
import 'package:agri_upd2/shared/colors_constants.dart';
import 'package:agri_upd2/shared/sharing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List data = [];
  List weig = [];
  List weigTime = [];

  CollectionReference Sheap = FirebaseFirestore.instance.collection('Sheap');

  void loadData() async {
    int dataRecieverIndex = 0;
    int weightIndex = 0;
    QuerySnapshot querySnapshot = await Sheap.get();
    data.addAll(querySnapshot.docs);

    DateFormat format = DateFormat("yyy-MM-dd");
    for (dataRecieverIndex = 0;
        dataRecieverIndex < data.length;
        dataRecieverIndex++) {
      DateTime dateTime =
          format.parse((data[dataRecieverIndex]['birthday']).toString());
      allData.add(DataStored(
        hisNum: data[dataRecieverIndex]['hisNum'],
        faNum: data[dataRecieverIndex]['faNum'],
        moNum: data[dataRecieverIndex]['moNum'],
        spec: data[dataRecieverIndex]['spec'],
        gender: data[dataRecieverIndex]['gender'],
        birthday: dateTime,
      ));
      allData[dataRecieverIndex].fireSaveNum =
          data[dataRecieverIndex]['fireSaveNum'];
      weig = data[dataRecieverIndex]['weight'];
      weigTime = data[dataRecieverIndex]['weightsTime'];
      for (weightIndex = 0; weightIndex < weig.length; weightIndex++) {
        (allData[dataRecieverIndex].weights).add(weig[weightIndex]);
        (allData[dataRecieverIndex].weightsTime).add(weigTime[weightIndex]);
      }
    }
  }

  calculateTimeWeight() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      Duration timeCalc = Duration(days: 1);
      int i = 0;
      print(allData.length);
      for (i = 0; i < allData.length; i++) {
        if ((allData[i].weights).length >= 3) {
          timeCalc = Duration(days: 2);
        } else {
          timeCalc = Duration(days: 1);
        }
//calculate the day
        DateTime dateTime = DateTime.parse(
            ((allData[i].weightsTime)[(allData[i].weightsTime).length - 1]));

        if ((DateTime.now().difference(dateTime)).inHours -
                DateTime.now().hour >=
            timeCalc.inHours) {
          allData[i].timeForWeight = true;
        }
      }
    });
    //Datalist();
  }

  @override
  void initState() {
    loadData();
    //calculateTimeWeight();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BTNgreen,
        title: Text(
          "Home",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 80),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                child: ClipOval(child: Image.asset("assets/images.jpeg")),
                radius: 100,
              ),
              SizedBox(
                height: 100,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Newdata()),
                    );

/*
                    print("hhh");
                    WorkManagerService.registerMyTask(
                        "Task#1",
                        "Task#2",
                        //  Duration(days: 1));
                        Duration(minutes: 2));
                  
                        
                    */
                  },
                  child: Text(
                    "New Data",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(BTNgreen),
                    padding: WidgetStateProperty.all(
                        EdgeInsets.fromLTRB(120, 0, 120, 0)),
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
                  )),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Datalist()),
                    );
                  },
                  child: Text(
                    "Stored Data",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(BTNgreen),
                    padding: WidgetStateProperty.all(
                        EdgeInsets.fromLTRB(112, 0, 112, 0)),
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}