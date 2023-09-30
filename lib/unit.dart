import 'dart:convert';

import 'package:mjdictionary/components/checkbox.dart';
import 'package:mjdictionary/components/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mjdictionary/components/checkbox_type.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/jsonProvider.dart';

class UnitPage extends StatefulWidget {
  final String unit;
  final String level;
  final List unitList;
  const UnitPage(
      {Key? key,
      required this.unit,
      required this.level,
      required this.unitList})
      : super(key: key);

  @override
  State<UnitPage> createState() => _UnitPageState();
}

class _UnitPageState extends State<UnitPage> {
  late String unit;
  late bool kanji = true;
  late bool hira = true;
  late bool meaning = true;
  late bool random = false;

  late List meaningList = [];

  final FlutterTts tts = FlutterTts();

  @override
  void initState() {
    super.initState();
    tts.setLanguage('ja');
    tts.setSpeechRate(0.4);
    unit = widget.unit;
    _getMeaningList();
  }

  _getMeaningList() async {
    final prefs = await SharedPreferences.getInstance();
    final storedData = prefs.getString("stored_data") ?? "";
    // print("SD>> $storedData");
    List jsonList = [];
    if (storedData != "") {
      jsonList = json.decode(storedData);

      setState(() {
        // unitList = getLessons(jsonList, lvl);

        meaningList = jsonList
            .where((o) =>
                o['level'].contains(widget.level) && o['lesson'].contains(unit))
            .toList();
      });
    }
  }

  void _showUnitActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Level'),
        // message: const Text('Message'),
        cancelButton: CupertinoActionSheetAction(
          /// This parameter indicates the action would be a default
          /// defualt behavior, turns the action's text to bold text.
          isDefaultAction: true,
          onPressed: () {
            // debugPrint("CHANGE LEVEL>> ${levelList[i]["level"]}");
            // setState(() {
            //   level = levelList[i]["level"];

            //   _getUnits(level);
            // });

            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        actions: <CupertinoActionSheetAction>[
          for (var i = 0; i < widget.unitList.length; i++)
            CupertinoActionSheetAction(
              /// This parameter indicates the action would be a default
              /// defualt behavior, turns the action's text to bold text.
              isDefaultAction: true,
              onPressed: () {
                // debugPrint("CHANGE LEVEL>> ${levelList[i]["level"]}");
                // setState(() {
                //   level = levelList[i]["level"];

                //   _getUnits(level);
                // });
                setState(() {
                  unit = widget.unitList[i]["lesson"];
                  _getMeaningList();
                });
                Navigator.pop(context);
              },
              child: Text("${widget.unitList[i]["lesson"]}"),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: mainColor,
        toolbarHeight: 0,
      ),
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                // color: mainColor,
                height: 80,
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
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: Color.fromARGB(255, 137, 37, 37),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showUnitActionSheet(context);
                      },
                      child: Row(
                        children: [
                          Text(
                            "Unit $unit ",
                            style: TextStyle(
                              fontSize: 19.0,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()
                                ..shader = const LinearGradient(
                                  colors: <Color>[
                                    Colors.black,
                                    Color.fromARGB(255, 137, 37, 37),
                                    Color.fromARGB(255, 137, 37, 37),
                                  ],
                                ).createShader(
                                  const Rect.fromLTWH(0.0, 0.0, 200.0, 100.0),
                                ),
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 30,
                            color: Color.fromARGB(255, 137, 37, 37),
                          )
                        ],
                      ),
                    ),
                    Text(
                      "${widget.level} ",
                      style: TextStyle(
                        fontSize: 19.0,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..shader = const LinearGradient(
                            colors: <Color>[
                              Colors.black,
                              Color.fromARGB(255, 137, 37, 37),
                              Color.fromARGB(255, 137, 37, 37),
                            ],
                          ).createShader(
                            const Rect.fromLTWH(0.0, 0.0, 200.0, 100.0),
                          ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomCheckbox(
                      size: 20,
                      type: GFCheckboxType.custom,
                      activeBorderColor: const Color.fromARGB(255, 137, 37, 37),
                      customColor: const Color.fromARGB(255, 137, 37, 37),
                      activeColor: const Color.fromARGB(255, 137, 37, 37),
                      inactiveColor: Colors.transparent,
                      inactiveBorderColor:
                          const Color.fromARGB(255, 192, 80, 80),
                      textActiveColor: const Color.fromARGB(255, 137, 37, 37),
                      textInactiveColor: const Color.fromARGB(255, 192, 80, 80),
                      textValue: "Kanji",
                      onChanged: (value) {
                        setState(() {
                          if (!hira && !meaning) {
                          } else {
                            kanji = value;
                          }
                        });
                      },
                      value: kanji,
                      inactiveIcon: null,
                    ),
                    CustomCheckbox(
                      size: 20,
                      type: GFCheckboxType.custom,
                      activeBorderColor: const Color.fromARGB(255, 137, 37, 37),
                      customColor: const Color.fromARGB(255, 137, 37, 37),
                      activeColor: const Color.fromARGB(255, 137, 37, 37),
                      inactiveColor: Colors.transparent,
                      inactiveBorderColor:
                          const Color.fromARGB(255, 192, 80, 80),
                      textActiveColor: const Color.fromARGB(255, 137, 37, 37),
                      textInactiveColor: const Color.fromARGB(255, 192, 80, 80),
                      textValue: "Hira",
                      onChanged: (value) {
                        setState(() {
                          if (!kanji && !meaning) {
                          } else {
                            hira = value;
                          }
                        });
                      },
                      value: hira,
                      inactiveIcon: null,
                    ),
                    CustomCheckbox(
                      size: 20,
                      type: GFCheckboxType.custom,
                      activeBorderColor: const Color.fromARGB(255, 137, 37, 37),
                      customColor: const Color.fromARGB(255, 137, 37, 37),
                      activeColor: const Color.fromARGB(255, 137, 37, 37),
                      inactiveColor: Colors.transparent,
                      inactiveBorderColor:
                          const Color.fromARGB(255, 192, 80, 80),
                      textActiveColor: const Color.fromARGB(255, 137, 37, 37),
                      textInactiveColor: const Color.fromARGB(255, 192, 80, 80),
                      textValue: "Meaning",
                      onChanged: (value) {
                        setState(() {
                          if (!kanji && !hira) {
                          } else {
                            meaning = value;
                          }
                        });
                      },
                      value: meaning,
                      inactiveIcon: null,
                    ),
                    CustomCheckbox(
                      size: 20,
                      type: GFCheckboxType.custom,
                      activeBorderColor: const Color.fromARGB(255, 137, 37, 37),
                      customColor: const Color.fromARGB(255, 137, 37, 37),
                      activeColor: const Color.fromARGB(255, 137, 37, 37),
                      inactiveColor: Colors.transparent,
                      inactiveBorderColor:
                          const Color.fromARGB(255, 192, 80, 80),
                      textActiveColor: const Color.fromARGB(255, 137, 37, 37),
                      textInactiveColor: const Color.fromARGB(255, 192, 80, 80),
                      textValue: "Random",
                      onChanged: (value) {
                        setState(() {
                          random = value;

                          if (random) {
                            meaningList.shuffle();
                          } else {
                            _getMeaningList();
                          }
                        });
                      },
                      value: random,
                      inactiveIcon: null,
                    ),
                  ],
                ),
              ),

              //
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 13.0, left: 0, right: 0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          // itemExtent: 50,
                          padding: const EdgeInsets.all(0),
                          itemCount: meaningList.length,
                          // separatorBuilder: (BuildContext context, int index) =>
                          //     const Divider(color: Colors.amberAccent,),
                          itemBuilder: (BuildContext context, int index) {
                            // return Container(child: Text("ABC>>> ${snapshot.data.length}"),);
                            return Container(
                              padding: index == meaningList.length - 1
                                  ? const EdgeInsets.only(bottom: 30)
                                  : const EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                  color: index % 2 == 0
                                      ? Colors.white
                                      : Colors.amber[50]),
                              child: meaningList[index]["type"] == "kanji"
                                  ? Container()
                                  : ListTile(
                                      dense: true,
                                      visualDensity: const VisualDensity(
                                          vertical: -3), // to compact
                                      onTap: () {
                                        // debugPrint("CLICK>> ${snapshot.data[index]}");
                                      },
                                      title: Text(
                                        "${kanji ? meaningList[index]["kanji"] == '' ? hira ? "" : meaningList[index]["japan"] : meaningList[index]["kanji"] + "   " : ""}"
                                        "${hira ? meaningList[index]["japan"] : ""}",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            // color: Color.fromARGB(255, 6, 111, 134),
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        meaning
                                            ? meaningList[index]["myanmar"]
                                            : "",
                                        style: const TextStyle(
                                            fontSize: 11,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      trailing: GestureDetector(
                                          onTap: () async {
                                            debugPrint("Click Speak>>>");
                                            await tts.speak(
                                                "${meaningList[index]["japan"]}");
                                            debugPrint("Click Speak Done>>>");
                                          },
                                          child: const Icon(
                                            Icons.volume_down_alt,
                                          )),
                                    ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
