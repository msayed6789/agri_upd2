


import 'package:agri_upd2/shared/colors_constants.dart';
import 'package:agri_upd2/shared/snakbar.dart';
import 'package:flutter/material.dart';

class CardF extends StatelessWidget {
  
  final String hisNumber;
  final DateTime birthday;
  final bool status;
  final Function deleteCard;
  final int index;

  const CardF({
    super.key,
    required this.hisNumber,
    required this.birthday,
    required this.status,
    required this.deleteCard,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: status ? BTNgreen : BTNgreen,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                hisNumber,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    decoration: TextDecoration.none,
                    color: Colors.black),
              ),
              Text(
                "${birthday.day}/${birthday.month}/${birthday.year}",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    decoration: TextDecoration.none,
                    color: Colors.black),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: status ? Colors.red : BTNgreen),
                padding: EdgeInsets.all(5),
                child: Text(
                  "1",
                  style: TextStyle(
                      fontSize: 20, color: status ? Colors.black : BTNgreen),
                ),
              ),
              IconButton(
                  onPressed: () {
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
                                          showSnackBar(context,
                                              "The card has been successfully deleted");
                                          deleteCard(index);
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
                  },
                  icon: Icon(
                    size: 27,
                    Icons.delete,
                    color: Colors.black,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}