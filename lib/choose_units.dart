import 'dart:convert';

import 'package:mjdictionary/components/colors.dart';
import 'package:mjdictionary/components/jsonprovider.dart';
import 'package:mjdictionary/kanji.dart';
import 'package:mjdictionary/kotoba.dart';
import 'package:mjdictionary/unit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/gradient_text.dart';

class ChooseUnitsPage extends StatefulWidget {
  const ChooseUnitsPage({
    super.key,
  });

  @override
  State<ChooseUnitsPage> createState() => _ChooseUnitsPageState();
}

class _ChooseUnitsPageState extends State<ChooseUnitsPage> {
  late String level = "";
  late String unit = "";
  late List unitList = [];
  late var storedData;

  @override
  void initState() {
    super.initState();

    if (levelList.isNotEmpty) {
      level = levelList[0]["level"];
      _getUnits(level);
    }
  }

  _getUnits(lvl) async {
    final prefs = await SharedPreferences.getInstance();
    storedData = prefs.getString("stored_data") ?? "";
    // print("SD>> $storedData");
    List jsonList = [];
    if (storedData != "") {
      jsonList = json.decode(storedData);

      setState(() {
        unitList = getLessons(jsonList, lvl);
        for (var i = 0; i < unitList.length; i++) {
          unitList[i]["selected"] = false;
        }
      });
    }
  }

// This shows a CupertinoModalPopup which hosts a CupertinoActionSheet.
  void _showLevelActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Level'),
        // message: const Text('Message'),
        actions: <CupertinoActionSheetAction>[
          for (var i = 0; i < levelList.length; i++)
            CupertinoActionSheetAction(
              /// This parameter indicates the action would be a default
              /// defualt behavior, turns the action's text to bold text.
              isDefaultAction: true,
              onPressed: () {
                debugPrint("CHANGE LEVEL>> ${levelList[i]["level"]}");
                setState(() {
                  level = levelList[i]["level"];

                  _getUnits(level);
                });
                Navigator.pop(context);
              },
              child: Text(levelList[i]["level"]),
            ),

          // CupertinoActionSheetAction(
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          //   child: const Text('Action'),
          // ),
          // CupertinoActionSheetAction(
          //   /// This parameter indicates the action would perform
          //   /// a destructive action such as delete or exit and turns
          //   /// the action's text color to red.
          //   isDestructiveAction: true,
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          //   child: const Text('Destructive Action'),
          // ),
        ],
      ),
    );
  }

  startKotoba() async {
    debugPrint("SELECTED Start >>> ");
    List choosedUnitsLst = [];
    if (unitList.isNotEmpty) {
      for (var i = 0; i < unitList.length; i++) {
        if (unitList[i]["selected"] == true) {
          List jsonList = json.decode(storedData);
          for (var j = 0; j < jsonList.length; j++) {
            if ((unitList[i]["lesson"] == jsonList[j]["lesson"]) &&
                jsonList[j]["type"] != "kanji") {
              choosedUnitsLst.add(jsonList[j]);
            }
          }
        }
      }
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return KotobaPage(
            kotobalist: choosedUnitsLst,
          );
        }));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                // color: mainColor,
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0)),
                  color: mainColor,
                ),
              )),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: Color.fromARGB(255, 137, 37, 37),
                      ),
                    ),
                    GradientText(
                      "Choose Units",
                      style: TextStyle(
                        fontSize: 19.0,
                        fontWeight: FontWeight.bold,
                      ),
                      gradient: LinearGradient(colors: [
                        Colors.black,
                        Color.fromARGB(255, 137, 37, 37),
                      ]),
                    ),
                    // Text(
                    //   widget.tabIndex == 1 ? "Kanji" : "Lessons",
                    //   style: TextStyle(
                    //     fontSize: 19.0,
                    //     fontWeight: FontWeight.bold,
                    //     foreground: Paint()
                    //       ..shader = const LinearGradient(
                    //         colors: <Color>[
                    //           Colors.black,
                    //           Color.fromARGB(255, 137, 37, 37),
                    //           Color.fromARGB(255, 137, 37, 37),
                    //         ],
                    //       ).createShader(
                    //         const Rect.fromLTWH(0.0, 0.0, 200.0, 100.0),
                    //       ),
                    //   ),
                    // ),
                    level.isEmpty
                        ? Container()
                        : GestureDetector(
                            onTap: () {
                              _showLevelActionSheet(context);
                              debugPrint("Click Level>>");
                            },
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    GradientText(
                                      level,
                                      style: TextStyle(
                                        fontSize: 19.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      gradient: LinearGradient(colors: [
                                        Colors.black,
                                        Color.fromARGB(255, 137, 37, 37),
                                      ]),
                                    ),
                                    // Text(
                                    //   level,
                                    //   style: TextStyle(
                                    //     fontSize: 19.0,
                                    //     fontWeight: FontWeight.bold,
                                    //     foreground: Paint()
                                    //       ..shader = const LinearGradient(
                                    //         colors: <Color>[
                                    //           Colors.black,
                                    //           Color.fromARGB(255, 137, 37, 37),
                                    //           Color.fromARGB(255, 137, 37, 37),
                                    //         ],
                                    //       ).createShader(
                                    //         const Rect.fromLTWH(
                                    //             0.0, 0.0, 200.0, 100.0),
                                    //       ),
                                    //   ),
                                    // ),
                                    const Icon(
                                      Icons.swap_horiz_rounded,
                                      color: Color.fromARGB(255, 137, 37, 37),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                  ],
                ),
              ),

              //
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                  child: Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4),
                          itemCount: unitList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                // clickCard(unitList[index]["lesson"]);
                                setState(() {
                                  if (unitList[index]["selected"]) {
                                    unitList[index]["selected"] = false;
                                  } else {
                                    unitList[index]["selected"] = true;
                                  }
                                });
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: unitList[index]["selected"]
                                      ? BorderSide(
                                          // border color
                                          color: Colors.blue.shade200,
                                          // border thickness
                                          width: 3,
                                        )
                                      : BorderSide.none,
                                  //set border radius more than 50% of height and width to make circle
                                ),
                                elevation: 5,
                                shadowColor: Colors.black,
                                color: Colors.amber[100],
                                // color: Colors.primaries[index % 10][100],
                                child: Stack(
                                  children: [
                                    const Positioned(
                                        top: 5,
                                        left: 10,
                                        child: Text(
                                          "Unit",
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400),
                                        )),
                                    Center(
                                        child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        '${unitList[index]["lesson"]}',
                                        style: const TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                startKotoba();
              },
              child: Container(
                // color: mainColor,
                // height: 50,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0)),
                  color: mainColor,
                ),
                child: GestureDetector(
                  onTap: () {
                    startKotoba();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Start",
                        style: TextStyle(
                          fontSize: 19.0,
                          fontWeight: FontWeight.bold,
                        ),
                        // gradient: LinearGradient(colors: [
                        //   Colors.black,
                        //   Color.fromARGB(255, 137, 37, 37),
                        // ]
                        // ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
