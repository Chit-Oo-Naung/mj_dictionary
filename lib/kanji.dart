import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/checkbox.dart';
import 'components/checkbox_type.dart';
import 'components/colors.dart';
import 'components/gradient_text.dart';

class KanjiPage extends StatefulWidget {
  final String unit;
  final String level;
  final List unitList;
  const KanjiPage(
      {super.key,
      required this.unit,
      required this.level,
      required this.unitList});

  @override
  State<KanjiPage> createState() => _KanjiPageState();
}

class _KanjiPageState extends State<KanjiPage>
    with SingleTickerProviderStateMixin {
  late int tabIndex = 0;
  late TabController tabController;
  final FlutterTts tts = FlutterTts();

  late String unit;

  late bool kanji = true;
  late bool hira = true;
  late bool meaning = true;
  late bool random = false;

  late List kanjiList = [];
  late List meaningList = [];

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();

    tabController.addListener(() {
      // if(tabController.previousIndex != tabController.index){
      setState(() {
        tabIndex = tabController.index;
      });
      // }
    });

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

        kanjiList = jsonList
            .where((o) =>
                o['level'].contains(widget.level) &&
                o['lesson'].contains(unit) &&
                o['type'].contains("kanji"))
            .toList();

        List mmList = jsonList
            .where((o) =>
                o['level'].contains(widget.level) &&
                o['lesson'].contains(unit) &&
                o['type'].contains("kanji"))
            .toList();
        meaningList = [];
        for (var i = 0; i < mmList.length; i++) {
          for (var j = 0; j < mmList[i]["sentence"].length; j++) {
            meaningList.add(mmList[i]["sentence"][j]);
          }
        }
        debugPrint("MMLIST >> $meaningList");
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
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
                height: tabIndex == 0 ? 84 : 130,
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
                          GradientText(
                            "Unit $unit ",
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
                          //   "Unit $unit ",
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

              //
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, left: 0, right: 0, bottom: 0),
                  child: Column(
                    children: [
                      // give the tab bar a height [can change hheight to preferred height]
                      Container(
                        height: 45,
                        color: Colors.transparent,
                        // decoration: BoxDecoration(
                        //   color:Colors.transparent,
                        //   // borderRadius: BorderRadius.circular(
                        //   //   25.0,
                        //   // ),
                        // ),
                        child: TabBar(
                          controller: tabController,
                          onTap: (((value) => {
                                setState(() {
                                  tabIndex = value;
                                })
                              })),
                          // give the indicator a decoration (color and border radius)
                          indicator: BoxDecoration(
                            borderRadius: tabIndex == 0
                                ? const BorderRadius.only(
                                    bottomLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0))
                                : const BorderRadius.only(
                                    bottomLeft: Radius.circular(10.0),
                                    topLeft: Radius.circular(10.0),
                                    bottomRight: Radius.circular(0.0)),
                            color: Colors.amber[600],
                          ),
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey[800],
                          tabs: const [
                            Tab(
                              text: 'Writing',
                            ),
                            Tab(
                              text: 'Meaning',
                            ),
                          ],
                        ),
                      ),
                      // tab bar view here
                      Expanded(
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            // first tab bar view widget
                            Container(
                                // color: Colors,.red,
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 3, bottom: 10),
                                child: KanjiWritingListView(
                                  kanjiList: kanjiList,
                                )),

                            // second tab bar view widget
                            Container(
                                // color: Colors,.red,
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          top: 0,
                                          bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomCheckbox(
                                            size: 19,
                                            type: GFCheckboxType.custom,
                                            activeBorderColor:
                                                const Color.fromARGB(
                                                    255, 137, 37, 37),
                                            customColor: const Color.fromARGB(
                                                255, 137, 37, 37),
                                            activeColor: const Color.fromARGB(
                                                255, 137, 37, 37),
                                            inactiveColor: Colors.transparent,
                                            inactiveBorderColor:
                                                const Color.fromARGB(
                                                    255, 192, 80, 80),
                                            textActiveColor:
                                                const Color.fromARGB(
                                                    255, 137, 37, 37),
                                            textInactiveColor:
                                                const Color.fromARGB(
                                                    255, 192, 80, 80),
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
                                            size: 19,
                                            type: GFCheckboxType.custom,
                                            activeBorderColor:
                                                const Color.fromARGB(
                                                    255, 137, 37, 37),
                                            customColor: const Color.fromARGB(
                                                255, 137, 37, 37),
                                            activeColor: const Color.fromARGB(
                                                255, 137, 37, 37),
                                            inactiveColor: Colors.transparent,
                                            inactiveBorderColor:
                                                const Color.fromARGB(
                                                    255, 192, 80, 80),
                                            textActiveColor:
                                                const Color.fromARGB(
                                                    255, 137, 37, 37),
                                            textInactiveColor:
                                                const Color.fromARGB(
                                                    255, 192, 80, 80),
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
                                            size: 19,
                                            type: GFCheckboxType.custom,
                                            activeBorderColor:
                                                const Color.fromARGB(
                                                    255, 137, 37, 37),
                                            customColor: const Color.fromARGB(
                                                255, 137, 37, 37),
                                            activeColor: const Color.fromARGB(
                                                255, 137, 37, 37),
                                            inactiveColor: Colors.transparent,
                                            inactiveBorderColor:
                                                const Color.fromARGB(
                                                    255, 192, 80, 80),
                                            textActiveColor:
                                                const Color.fromARGB(
                                                    255, 137, 37, 37),
                                            textInactiveColor:
                                                const Color.fromARGB(
                                                    255, 192, 80, 80),
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
                                            size: 19,
                                            type: GFCheckboxType.custom,
                                            activeBorderColor:
                                                const Color.fromARGB(
                                                    255, 137, 37, 37),
                                            customColor: const Color.fromARGB(
                                                255, 137, 37, 37),
                                            activeColor: const Color.fromARGB(
                                                255, 137, 37, 37),
                                            inactiveColor: Colors.transparent,
                                            inactiveBorderColor:
                                                const Color.fromARGB(
                                                    255, 192, 80, 80),
                                            textActiveColor:
                                                const Color.fromARGB(
                                                    255, 137, 37, 37),
                                            textInactiveColor:
                                                const Color.fromARGB(
                                                    255, 192, 80, 80),
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
                                    Expanded(
                                      child: KanjiMeaningListView(
                                        meaningList: meaningList,
                                        kanji: kanji,
                                        hira: hira,
                                        meaning: meaning,
                                        random: random,
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class KanjiWritingListView extends StatelessWidget {
  final kanjiList;
  const KanjiWritingListView({Key? key, required this.kanjiList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: kanjiList.length,
      itemBuilder: (context, index) {
        return InkWell(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              //set border radius more than 50% of height and width to make circle
            ),
            elevation: 5,
            shadowColor: Colors.black,
            color: Colors.amber[100],
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: mainColor))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 80,
                        width: MediaQuery.of(context).size.width * 0.25,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              bottomLeft: Radius.circular(0.0)),
                          color: mainColor,
                        ),
                        child: Center(
                            child: Text(
                          kanjiList[index]["kanji"],
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        )),
                      ),
                      Container(
                        // color:Colors.blue,
                        width: MediaQuery.of(context).size.width * 0.68,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        "Konnyomi",
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  child: Text(
                                    kanjiList[index]["konnyomi"],
                                    style: TextStyle(
                                        fontSize: 19.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        "Onnyomi",
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  child: Text(
                                    kanjiList[index]["onnyomi"],
                                    style: TextStyle(
                                        fontSize: 19.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            // Container(
                            //   // color: Colors.red,
                            //   child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceEvenly,
                            //     crossAxisAlignment: CrossAxisAlignment.center,
                            //     children: [
                            //       Container(
                            //         child: Text(
                            //           "Konnyomi",
                            //           style: TextStyle(fontSize: 14.0),
                            //         ),
                            //       ),
                            //       Container(
                            //         child: Text(
                            //           "Onnyomi",
                            //           style: TextStyle(fontSize: 14.0),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            // Container(
                            //   // color: Colors.red,
                            //   child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceEvenly,
                            //     crossAxisAlignment: CrossAxisAlignment.center,
                            //     children: [
                            //       Container(
                            //         child: Text(
                            //           kanjiList[index]["konnyomi"],
                            //           style: TextStyle(
                            //               fontSize: 19.0,
                            //               fontWeight: FontWeight.bold),
                            //         ),
                            //       ),
                            //       Container(
                            //         child: Text(
                            //           kanjiList[index]["onnyomi"],
                            //           style: TextStyle(
                            //               fontSize: 19.0,
                            //               fontWeight: FontWeight.bold),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // for (var i = 0;
                //     i < kanjiList[index]["sentence"].length;
                //     i++) ...[
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    // itemExtent: 50,
                    padding: const EdgeInsets.all(0),
                    itemCount: kanjiList[index]["sentence"].length,
                    // separatorBuilder: (BuildContext context, int index) =>
                    //     const Divider(color: Colors.amberAccent,),
                    itemBuilder: (BuildContext context, int i) {
                      return ListTile(
                        dense: true,

                        visualDensity:
                            VisualDensity(vertical: -3), // to compact
                        leading: Container(
                            width: MediaQuery.of(context).size.width * 0.23,
                            child: Text(
                                kanjiList[index]["sentence"][i]["kanji"],
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        title: Text(
                          kanjiList[index]["sentence"][i]["japan"],
                        ),
                        // subtitle:  Text('My City, CA 99984'),

                        trailing:
                            Text(kanjiList[index]["sentence"][i]["myanmar"]),
                      );
                    }),
              ],
              // ],
            ),
          ),
        );
      },
    );
  }
}

class KanjiMeaningListView extends StatelessWidget {
  final List meaningList;
  final bool kanji;
  final bool hira;
  final bool meaning;
  final bool random;
  KanjiMeaningListView(
      {Key? key,
      required this.meaningList,
      required this.kanji,
      required this.hira,
      required this.meaning,
      required this.random})
      : super(key: key);

  final FlutterTts tts = FlutterTts();
  @override
  void initState() {
    // tabController = TabController(length: 2, vsync: this);
    // super.initState();

    tts.setLanguage('ja');
    tts.setSpeechRate(0.4);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
              color: index % 2 == 0 ? Colors.white : Colors.amber[50]),
          child: ListTile(
            dense: true,
            visualDensity: const VisualDensity(vertical: -3), // to compact
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
              meaning ? meaningList[index]["myanmar"] : "",
              style: const TextStyle(
                  fontSize: 11,
                  color: Colors.black54,
                  fontWeight: FontWeight.normal),
            ),
            trailing: GestureDetector(
                onTap: () async {
                  debugPrint("Click Speak>>>");
                  await tts.speak("${meaningList[index]["japan"]}");
                  debugPrint("Click Speak Done>>>");
                },
                child: const Icon(
                  Icons.volume_down_alt,
                )),
          ),
        );
      },
    );
  }
}
