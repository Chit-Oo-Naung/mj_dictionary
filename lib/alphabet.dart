import 'dart:ui';

import 'package:mjdictionary/components/alphabetJSON.dart';
import 'package:mjdictionary/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'components/gradient_text.dart';

class AlphabetPage extends StatefulWidget {
  const AlphabetPage({super.key});

  @override
  State<AlphabetPage> createState() => _AlphabetPageState();
}

class _AlphabetPageState extends State<AlphabetPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late int tabIndex = 0;

  final FlutterTts tts = FlutterTts();

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();

    tts.setLanguage('ja');
    tts.setSpeechRate(0.4);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
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
                height: 76,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0)),
                  color: mainColor,
                ),
              )),
          Column(children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 0),
              child: Row(
                children: [
                  GradientText(
                    "Alphabet",
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
                  //   "Alphabet",
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
                ],
              ),
            ),

            //
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 0, right: 0),
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
                                  bottomRight: Radius.circular(20.0)),
                          color: Colors.amber[600],
                        ),
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey[800],
                        tabs: const [
                          Tab(
                            text: 'Hiragana',
                          ),
                          Tab(
                            text: 'Katakana',
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
                                  left: 8, right: 8, top: 3, bottom: 3),
                              child: AlphabetListView(
                                list: hiraganaLst,
                              )),

                          // second tab bar view widget
                          Container(
                              // color: Colors,.red,
                              padding: const EdgeInsets.all(8),
                              child: AlphabetListView(
                                list: katakanaLst,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}

class AlphabetListView extends StatelessWidget {
  final List list;

  const AlphabetListView({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FlutterTts tts = FlutterTts();
    @override
    void initState() {
      // tabController = TabController(length: 2, vsync: this);
      // super.initState();

      tts.setLanguage('ja');
      tts.setSpeechRate(0.4);
    }

    void showFancyCustomDialog(BuildContext context, imgName) {
      Dialog fancyDialog = Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
          ),
          height: 300.0,
          width: 300.0,
          child: Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Image.asset(imgName),
              ),
              // Container(
              //   width: double.infinity,
              //   height: 50,
              //   alignment: Alignment.bottomCenter,
              //   decoration: BoxDecoration(
              //     color: Colors.red,
              //     borderRadius: BorderRadius.only(
              //       topLeft: Radius.circular(12),
              //       topRight: Radius.circular(12),
              //     ),
              //   ),
              //   child: Align(
              //     alignment: Alignment.center,
              //     child: Text(
              //       "Dialog Title!",
              //       style: TextStyle(
              //           color: Colors.white,
              //           fontSize: 20,
              //           fontWeight: FontWeight.w600),
              //     ),
              //   ),
              // ),
              Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Got it!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
              // Align(
              //   // These values are based on trial & error method
              //   alignment: Alignment(1.05, -1.05),
              //   child: InkWell(
              //     onTap: () {
              //       Navigator.pop(context);
              //     },
              //     child: Container(
              //       decoration: BoxDecoration(
              //         color: Colors.grey[200],
              //         borderRadius: BorderRadius.circular(12),
              //       ),
              //       child: Icon(
              //         Icons.close,
              //         color: Colors.black,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      );
      showDialog(
          context: context, builder: (BuildContext context) => fancyDialog);
    }

    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return list[index]["jp"] == ""
            ? Container()
            : GestureDetector(
                onTap: () async {
                  await tts.setSharedInstance(true);
                  await tts.awaitSynthCompletion(true);
                  await tts.awaitSpeakCompletion(true);
                  await tts.speak("${list[index]["jp"]}");
                },
                onLongPress: () {
                  if (list[index]["img"] != "") {
                    showFancyCustomDialog(context, list[index]["img"]);
                  }
                },
                child: Card(
                  // color: Colors.primaries[index % 10],
                  color: Colors.amber[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    //set border radius more than 50% of height and width to make circle
                  ),
                  shadowColor: Colors.amberAccent,
                  elevation: 5,
                  child: Stack(
                    children: [
                      list[index]["img"] == ""
                          ? Container()
                          : Positioned(
                              right: 5,
                              bottom: 5,
                              child: Icon(
                                Icons.arrow_upward_rounded,
                                size: 11,
                                color: Colors.grey,
                              )),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${list[index]["jp"]}",
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${list[index]["eng"]}",
                              style: const TextStyle(
                                  color: Colors.black87, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
