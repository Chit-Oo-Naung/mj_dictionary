import 'dart:convert';

import 'package:mjdictionary/common/global_constant.dart';
import 'package:mjdictionary/components/colors.dart';
import 'package:mjdictionary/components/jsonprovider.dart';
import 'package:mjdictionary/kanji.dart';
import 'package:mjdictionary/unit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mjdictionary/utils/colors_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/gradient_text.dart';

class LessonsPage extends StatefulWidget {
  final int tabIndex;
  const LessonsPage({
    super.key,
    required this.tabIndex,
  });

  @override
  State<LessonsPage> createState() => _LessonsPageState();
}

class _LessonsPageState extends State<LessonsPage> {
  // late String level = "";
  late String unit = "";
  late List unitList = [];

  @override
  void initState() {
    super.initState();

    if (levelList.isNotEmpty) {
      if (level.isEmpty) {
        level = levelList[0]["level"];
      }

      _getUnits(level);
    }
  }

  _getUnits(lvl) async {
    final prefs = await SharedPreferences.getInstance();
    final storedData = prefs.getString("stored_data") ?? "";
    // print("SD>> $storedData");
    List jsonList = [];
    if (storedData != "") {
      jsonList = json.decode(storedData);

      setState(() {
        if (widget.tabIndex == 1) {
          unitList = getKanjiLessons(jsonList, lvl);
          // unitList = getLessons(jsonList, lvl);
        } else {
          unitList = getLessons(jsonList, lvl);
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

  clickCard(unit) async {
    print("TABINDEX>> ${widget.tabIndex}");
    if (widget.tabIndex == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return KanjiPage(
          unit: unit,
          level: level,
          unitList: unitList,
        );
      }));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return UnitPage(
          unit: unit,
          level: level,
          unitList: unitList,
        );
      }));
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
                padding: const EdgeInsets.only(left: 15, right: 15, top: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GradientText(
                      widget.tabIndex == 1 ? "Kanji" : "Lessons",
                      style: TextStyle(
                        fontSize: 19.0,
                        fontWeight: FontWeight.bold,
                      ),
                      gradient: LinearGradient(colors: [
                        Colors.black,
                        secondaryColor,
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
                    //           secondaryColor,
                    //           secondaryColor,
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
                                        secondaryColor,
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
                                    //           secondaryColor,
                                    //           secondaryColor,
                                    //         ],
                                    //       ).createShader(
                                    //         const Rect.fromLTWH(
                                    //             0.0, 0.0, 200.0, 100.0),
                                    //       ),
                                    //   ),
                                    // ),
                                     Icon(
                                      Icons.swap_horiz_rounded,
                                      color: secondaryColor,
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
                      const EdgeInsets.only(top: 18.0, left: 10, right: 10),
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
                                clickCard(unitList[index]["lesson"]);
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
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
        ],
      ),
    );
  }
}
