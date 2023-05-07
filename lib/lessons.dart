import 'dart:convert';

import 'package:dictionary/components/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LessonsPage extends StatefulWidget {
  const LessonsPage({super.key});

  @override
  State<LessonsPage> createState() => _LessonsPageState();
}

class _LessonsPageState extends State<LessonsPage> {
  late String level = "N5";
  late String unit = "";

// This shows a CupertinoModalPopup which hosts a CupertinoActionSheet.
  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Title'),
        message: const Text('Message'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            /// This parameter indicates the action would be a default
            /// defualt behavior, turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Default Action'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Action'),
          ),
          CupertinoActionSheetAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as delete or exit and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Destructive Action'),
          ),
        ],
      ),
    );
  }

  clickCard() async {
    final prefs = await SharedPreferences.getInstance();
    final storedData = prefs.getString("stored_data") ?? "";
    // print("SD>> $storedData");
    if (storedData != "") {
      List userData = json.decode(storedData);
      // _streamController.add(userData);

      List _modifiedData = groupJSONByUniqueKey(userData, "level");
      debugPrint("LEVEL LIST >>> ${_modifiedData}");
    }

    // final url = Uri.parse(
    //     'https://drive.google.com/uc?export=view&id=1LdFG9fEBi3TUTLiawVX2ghbWS8-qUvMI');
    // final response = await http.get(url);
    // // if (response.statusCode == 200) {
    // final data = json.decode(utf8.decode(response.bodyBytes));
    // prefs.setString("stored_data", json.encode(data["items"]));

    // // _streamController.add(data["items"]);
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
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Lessons",
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
                    GestureDetector(
                      onTap: () {
                        _showActionSheet(context);
                        debugPrint("Click Level>>");
                      },
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                level,
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
                                      const Rect.fromLTWH(
                                          0.0, 0.0, 200.0, 100.0),
                                    ),
                                ),
                              ),
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
                      const EdgeInsets.only(top: 18.0, left: 10, right: 10),
                  child: Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4),
                          itemCount: 25,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: (){
                                clickCard();
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
                                        '${index + 1}',
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

List<dynamic> groupJSONByUniqueKey(
  List<dynamic> json,
  String uniqueKey,
) {
  Map filtered = Map();

  for (var i in json) {
    if (!filtered.containsKey(i[uniqueKey])) {
      filtered[i[uniqueKey]] = i;
    }
  }
  List result = [];
  filtered.forEach((k, v) => result.add(v));
  return result;
}

