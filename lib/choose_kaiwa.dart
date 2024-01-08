import 'dart:convert';

import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mjdictionary/common/global_constant.dart';
import 'package:mjdictionary/components/colors.dart';
import 'package:mjdictionary/components/gradient_text.dart';
import 'package:mjdictionary/components/jsonprovider.dart';
import 'package:mjdictionary/kaiwa.dart';
import 'package:mjdictionary/utils/colors_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ChooseKaiwaPage extends StatefulWidget {
  const ChooseKaiwaPage({super.key});

  @override
  State<ChooseKaiwaPage> createState() => _ChooseKaiwaPageState();
}

class _ChooseKaiwaPageState extends State<ChooseKaiwaPage> {
  late String level = "";

  late String unit = "";
  late List unitList = [];
  late List levelList = [];
  bool loading = true;
  // late List jsonList = [
  //   {
  //     "lesson": "1",
  //     "level": "N5",
  //     "audioUrl":
  //         "https://drive.google.com/uc?export=view&id=1OtVK0zS9SlN2UomNVqt3RUgCFq4LVQlp",
  //     "new": "",
  //     "messages": [
  //       {
  //         "speaker": "",
  //         "japan": "はじめまして",
  //         "myanmar": "တွေ့ရတာ ဝမ်းသာပါတယ်။",
  //         "isMe": false,
  //         "avatar": "",
  //         "type": "title",
  //         "newline": ""
  //       },
  //       {
  //         "speaker": "さとうさん",
  //         "japan": "おはようございます。",
  //         "myanmar": "မင်္ဂလာနံနက်ခင်းပါ။",
  //         "isMe": false,
  //         "avatar": "sato",
  //         "type": "text",
  //         "newline": ""
  //       },
  //       {
  //         "speaker": "やまださん",
  //         "japan": "おはようございます。さとうさん、こちらは　マイク・ミラーさんです。",
  //         "myanmar": "မင်္ဂလာနံနက်ခင်းပါ။ စတိုစံ သူက မိုက်(ခ်)မီလာစံဖြစ်ပါတယ်။",
  //         "isMe": true,
  //         "avatar": "yamada",
  //         "type": "text",
  //         "newline": ""
  //       },
  //       {
  //         "speaker": "ミラー さん",
  //         "japan": "はじめまして。マイク・ミラーです。アメリカから　きました。どうぞ　よろしく。",
  //         "myanmar":
  //             "တွေ့ရတာ ဝမ်းသာပါတယ်။ မိုက်(ခ်)မီလာဖြစ်ပါတယ်။ အမေရိကားကနေ လာခဲ့ပါတယ်။ ခင်ခင်မင်မင်ဆက်ဆံပေးပါ။",
  //         "isMe": false,
  //         "avatar": "mira",
  //         "type": "text",
  //         "newline": ""
  //       },
  //       {
  //         "speaker": "さとうさん",
  //         "japan": "さとうけいこです。 どうぞ　よろしく。",
  //         "myanmar": "စတိုခဲအိကို ဖြစ်ပါတယ်။ ခင်ခင်မင်မင်ဆက်ဆံပေးပါ။",
  //         "isMe": true,
  //         "avatar": "sato",
  //         "type": "text",
  //         "newline": ""
  //       }
  //     ],
  //     "audioclip": [
  //       {"time": "0:00:05", "index": 1},
  //       {"time": "0:00:07", "index": 2},
  //       {"time": "0:00:12", "index": 3},
  //       {"time": "0:00:18", "index": 4},
  //     ]
  //   },
  //   {
  //     "lesson": "26",
  //     "level": "N4",
  //     "new": "",
  //     "messages": [
  //       {
  //         "speaker": "",
  //         "japan": "",
  //         "myanmar": "",
  //         "isMe": false,
  //         "avatar": "",
  //         "type": "title",
  //         "newline": ""
  //       },
  //       {
  //         "speaker": "",
  //         "japan": "",
  //         "myanmar": "",
  //         "isMe": false,
  //         "avatar": "",
  //         "type": "text",
  //         "newline": ""
  //       }
  //     ],
  //     "audioclip": [
  //       {"time": "0:00:05", "index": 1}
  //     ]
  //   }
  // ];

  @override
  void initState() {
    super.initState();
    _getCloudData();
    // if (levelList.isNotEmpty) {
    //   if (level.isEmpty) {
    //     level = levelList[0]["level"];
    //   }

    //   _getUnits(level);
    // }
  }

  _getCloudData() async {
    // await addLevel(jsonList);
    final prefs = await SharedPreferences.getInstance();
    final storedData = prefs.getString("stored_kaiwa_data") ?? "";
    // print("SD>> $storedData");
    List jsonList = [];
    // bool restored = false;
    if (storedData != "") {
      jsonList = json.decode(storedData);
      // _streamController.add(userData);

      // _streamController.add(shuffle(jsonList));
      await addLevel(jsonList);
      setState(() {
        loading = false;
      });
      // restored = true;
      // List _modifiedData = groupJSONByUniqueKey(userData, "level");
      // debugPrint("LEVEL LIST >>> $_modifiedData");
    }

    try {
      final url = Uri.parse(
          'https://drive.google.com/uc?export=view&id=12jy5NVTeI_nvq_0xDThn36dMqmZT3lsx');
      final response = await http.get(url);
      // if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes));
      jsonList = data["items"];
      debugPrint("JSON LIST >> $jsonList");
      prefs.setString("stored_kaiwa_data", json.encode(data["items"]));
      setState(() async {
        // if (!restored) {
        //   jsonList = jsonList.where((o) => o['type'] != "kanji").toList();
        // }
        await addLevel(jsonList);
        loading = false;
      });
    } catch (er) {
      print(er);
    }
  }

  addLevel(List list) {
    levelList = groupJSONByUniqueKey(list, "level");
    debugPrint("LEVEL LIST >>> $levelList");
    if (levelList.isNotEmpty) {
      if (level.isEmpty) {
        level = levelList[0]["level"];
      }

      _getUnits(level);
    }
  }

  _getUnits(lvl) async {
    final prefs = await SharedPreferences.getInstance();
    final storedData = prefs.getString("stored_kaiwa_data") ?? "";
    // print("SD>> $storedData");
    List jsonList = [];
    if (storedData != "") {
      jsonList = json.decode(storedData);

      setState(() {
        unitList = getLessons(jsonList, lvl);
        debugPrint("UNIT LIST >> $unitList");
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
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return KaiwaPage(
        lesson: unit["lesson"],
        audioUrl: unit["audioUrl"],
        messages: unit["messages"],
        audioClip: unit["audioclip"],
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    Widget buildAnimatedItem(
      BuildContext context,
      int index,
      Animation<double> animation,
    ) =>
        // For example wrap with fade transition
        FadeTransition(
          opacity: Tween<double>(
            begin: 0,
            end: 1,
          ).animate(animation),
          // And slide transition
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0, -0.1),
              end: Offset.zero,
            ).animate(animation),
            // Paste you Widget
            child: GestureDetector(
              onTap: () {
                clickCard(unitList[index]);
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
                              fontSize: 13, fontWeight: FontWeight.w400),
                        )),
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '${unitList[index]["lesson"]}',
                        style: const TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),
        );

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
                        // CloseButton();
                        // if (choosedUnitsLst.isNotEmpty) {
                        //   choosedUnitsLst = [];
                        //   Navigator.of(context).pop();
                        // }
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: secondaryColor,
                      ),
                    ),
                    GradientText(
                      "Kaiwa",
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
              loading
                  ? Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.06),
                      child: CircularProgressIndicator(
                        color: Colors.black26,
                      ))
                  : Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 0.0, left: 10, right: 10),
                        child: Column(
                          children: [
                            Expanded(
                              child: LiveGrid.options(
                                options: options,
                                itemBuilder: buildAnimatedItem,
                                itemCount: unitList.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  // crossAxisSpacing: 16,
                                  // mainAxisSpacing: 16,
                                ),
                              ),
                              // GridView.builder(
                              //   gridDelegate:
                              //       const SliverGridDelegateWithFixedCrossAxisCount(
                              //           crossAxisCount: 4),
                              //   itemCount: unitList.length,
                              //   itemBuilder: (BuildContext context, int index) {
                              //     return GestureDetector(
                              //       onTap: () {
                              //         clickCard(unitList[index]["lesson"]);
                              //       },
                              //       child: Card(
                              //         shape: RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.circular(10),
                              //           //set border radius more than 50% of height and width to make circle
                              //         ),
                              //         elevation: 5,
                              //         shadowColor: Colors.black,
                              //         color: Colors.amber[100],
                              //         // color: Colors.primaries[index % 10][100],
                              //         child: Stack(
                              //           children: [
                              //             const Positioned(
                              //                 top: 5,
                              //                 left: 10,
                              //                 child: Text(
                              //                   "Unit",
                              //                   style: TextStyle(
                              //                       fontSize: 13,
                              //                       fontWeight: FontWeight.w400),
                              //                 )),
                              //             Center(
                              //                 child: Padding(
                              //               padding: const EdgeInsets.only(top: 8.0),
                              //               child: Text(
                              //                 '${unitList[index]["lesson"]}',
                              //                 style: const TextStyle(
                              //                     fontSize: 23,
                              //                     fontWeight: FontWeight.bold),
                              //               ),
                              //             )),
                              //           ],
                              //         ),
                              //       ),
                              //     );
                              //   },
                              // ),
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
