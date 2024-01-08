import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:mjdictionary/components/colors.dart';
import 'package:mjdictionary/components/gradient_text.dart';
import 'package:mjdictionary/components/jsonProvider.dart';
import 'package:mjdictionary/conversation_setting.dart';
import 'package:mjdictionary/utils/colors_util.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage({Key? key}) : super(key: key);

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  late Stream _stream;
  FocusNode nodeSearch = FocusNode();
  StreamController _streamController = StreamController();
  AutoScrollController _autoScrollController = AutoScrollController();

  // late Timer _debounce;
  late bool showClear = false;
  bool loading = true;

  late var lan = true; // true - romaji & japan, false - myanmar

  final FlutterTts tts = FlutterTts();

  bool playList = false;
  int playIndex = 0;
  final index = 0;
  int currentIndex = 0;

  @override
  void initState() {
    Paint.enableDithering = true;
    super.initState();
    // print("HOME>>>>");
    _stream = _streamController.stream;

    // _getData();
    tts.setLanguage('ja');
    tts.setSpeechRate(0.4);
    _getCloudData();
  }

  _getCloudData() async {
    final prefs = await SharedPreferences.getInstance();
    final storedData = prefs.getString("kaiwa_stored_data") ?? "";
    // print("SD>> $storedData");
    List jsonList = [];
    bool restored = false;
    if (storedData != "") {
      jsonList = json.decode(storedData);
      // _streamController.add(userData);

      _streamController.add(jsonList);
      restored = true;
      loading = false;
      setState(() {});
      // List _modifiedData = groupJSONByUniqueKey(userData, "level");
      // debugPrint("LEVEL LIST >>> $_modifiedData");
    }

    if (kaiwaFirstTime) {
      try {
        final url = Uri.parse(
            'https://drive.google.com/uc?export=view&id=1AjNIqg8Rkbc90WWXXLQo8Gdj8HzE45JR');
        final response = await http.get(url);
        // if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes));
        jsonList = data["items"];
        print("DATA>> $jsonList");
        prefs.setString("kaiwa_stored_data", json.encode(data["items"]));
        setState(() {
          kaiwaFirstTime = false;
          if (!restored) {
            // jsonList = jsonList.toList();
            _streamController.add(jsonList);
          }
          loading = false;

          // addLevel(jsonList);
        });
      } catch (er) {
        print(er);
      }
    }
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
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
                height: 40,
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
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: secondaryColor,
                      ),
                    ),
                    GradientText(
                      "Conversation",
                      style: TextStyle(
                        fontSize: 19.0,
                        fontWeight: FontWeight.bold,
                      ),
                      gradient: LinearGradient(colors: [
                        Colors.black,
                        secondaryColor,
                      ]),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ConversationSettingPage();
                        }));
                      },
                      child: Icon(
                        Icons.settings,
                        color: secondaryColor,
                      ),
                    ),
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
                      child: Container(
                        margin: const EdgeInsets.only(top: 18.0),
                        child: StreamBuilder(
                          stream: _stream,
                          builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                            if (snapshot.data == null) {
                              return const Center(
                                child: Text("Oops! no results found!"),
                              );
                            }

                            if (snapshot.data.length == 0) {
                              return const Center(
                                child: Text("Oops! no results found!"),
                              );
                            }

                            if (snapshot.data == "waiting") {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            return Stack(
                              children: [
                                ListView.separated(
                                  controller: _autoScrollController,
                                  keyboardDismissBehavior:
                                      ScrollViewKeyboardDismissBehavior.onDrag,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  // itemExtent: 50,
                                  padding: const EdgeInsets.all(0.0),
                                  // itemCount: snapshot.data.length,
                                  itemCount: snapshot.data == null
                                      ? 0
                                      : snapshot.data.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const Divider(height: 1),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    // return Container(child: Text("ABC>>> ${snapshot.data.length}"),);
                                    return AutoScrollTag(
                                      key: ValueKey(index),
                                      controller: _autoScrollController,
                                      index: index,
                                      highlightColor:
                                          const Color.fromRGBO(244, 67, 54, 1),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: currentIndex == index
                                                ? Border(
                                                    left: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 18, 121, 206),
                                                      width: 5.0,
                                                    ),
                                                  )
                                                : Border(),
                                            color: currentIndex == index
                                                ? Color.fromARGB(
                                                    255, 206, 216, 224)
                                                : index % 2 == 0
                                                    ? Colors.white
                                                    : Colors.amber[50]),
                                        child: ListTile(
                                          dense: true,
                                          visualDensity: const VisualDensity(
                                              vertical: -3), // to compact
                                          onTap: () {
                                            debugPrint(
                                                "CLICK>> ${snapshot.data[index]}");
                                            setState(() {
                                              currentIndex = index;
                                            });
                                          },
                                          title: Text(
                                            lan
                                                ? snapshot.data[index]["japan"]
                                                : snapshot.data[index]
                                                    ["english"],
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          // subtitle: Text(
                                          //   lan
                                          //       ? snapshot.data[index]["english"]
                                          //       : snapshot.data[index]["japan"],
                                          //   style: const TextStyle(
                                          //       fontSize: 11,
                                          //       color: Colors.black54,
                                          //       fontWeight: FontWeight.normal),
                                          // ),
                                          subtitle: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    snapshot.data[index]
                                                        ["english"],
                                                    style: const TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black54,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    snapshot.data[index]
                                                        ["myanmar"],
                                                    style: const TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black54,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          trailing: GestureDetector(
                                              onTap: () async {
                                                debugPrint("Click Speak>>>");
                                                // final languages =
                                                //     await tts.getLanguages;
                                                // print("LANGUAGES ==> $languages");
                                                // await tts.setSharedInstance(true);
                                                // tts.setLanguage('my');
                                                // await tts.speak(
                                                //     "${snapshot.data[index]["myanmar"]}");
                                                setState(() {
                                                  currentIndex = index;
                                                });
                                                await tts
                                                    .setSharedInstance(true);
                                                await tts
                                                    .awaitSynthCompletion(true);
                                                await tts
                                                    .awaitSpeakCompletion(true);
                                                tts.setLanguage('ja');
                                                await tts.speak(
                                                    "${snapshot.data[index]["japan"]}");
                                                debugPrint(
                                                    "Click Speak Done>>>");
                                              },
                                              child: const Icon(
                                                Icons.volume_down_alt,
                                              )),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Positioned(
                                  bottom: 10,
                                  right: 10,
                                  child: playList
                                      ? FloatingActionButton(
                                          onPressed: () {
                                            setState(() {
                                              playList = false;
                                            });
                                          },
                                          foregroundColor: Colors.black,
                                          backgroundColor: mainColor,
                                          child: const Icon(Icons.pause),
                                        )
                                      : FloatingActionButton(
                                          onPressed: () {
                                            setState(() async {
                                              playList = true;
                                              Future.delayed(
                                                  Duration(milliseconds: 500),
                                                  () async {
                                                await tts
                                                    .setSharedInstance(true);
                                                await tts
                                                    .awaitSynthCompletion(true);
                                                await tts
                                                    .awaitSpeakCompletion(true);
                                                for (var i = currentIndex;
                                                    i < snapshot.data.length;
                                                    i++) {
                                                  setState(() {
                                                    currentIndex = i;
                                                  });

                                                  _autoScrollController
                                                      .scrollToIndex(i,
                                                          preferPosition:
                                                              AutoScrollPosition
                                                                  .middle);
                                                  tts.setLanguage('ja');
                                                  await tts
                                                      .setSharedInstance(true);
                                                  await tts
                                                      .awaitSynthCompletion(
                                                          true);
                                                  await tts
                                                      .awaitSpeakCompletion(
                                                          true);
                                                  await tts.speak(
                                                      "${snapshot.data[i]["japan"]}");
                                                  // tts.setLanguage('en-US');
                                                  // await tts.speak(
                                                  //     "${snapshot.data[i]["english"]}");
                                                  if (snapshot.data.length -
                                                          1 ==
                                                      i) {
                                                    setState(() {
                                                      playList = false;
                                                      currentIndex = 0;
                                                      _autoScrollController
                                                          .scrollToIndex(0,
                                                              preferPosition:
                                                                  AutoScrollPosition
                                                                      .begin);
                                                    });
                                                  }
                                                  if (!playList) {
                                                    break;
                                                  }
                                                }
                                              });

                                              //   print("CLICK>>>");
                                              //   var lgh = snapshot.data.length;

                                              //   print("CLICK 2>>> $lgh");
                                            });
                                          },
                                          foregroundColor: Colors.black,
                                          backgroundColor: mainColor,
                                          child: const Icon(
                                              Icons.play_arrow_rounded),
                                        ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
            ],
          )
        ],
      ),
      // floatingActionButton:
    );
  }
}
