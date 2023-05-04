// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// int toggle = 0;

// class MyWidget extends StatefulWidget {
//   const MyWidget({super.key});

//   @override
//   State<MyWidget> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<MyWidget>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _con;
//   late TextEditingController _textEditingController;
//   @override
//   void initState() {
//     super.initState();
//     _textEditingController = TextEditingController();
//     _con = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 375),
//     );
//     toggle = 1;
//     _con.forward();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: Color(0xffF2F3F7),
//         child: Center(
//           child: Container(
//             height: 100.0,
//             width: 250.0,
//             alignment: Alignment(-1.0, 0.0),
//             child: AnimatedContainer(
//               duration: Duration(milliseconds: 375),
//               height: 48.0,
//               width: (toggle == 0) ? 48.0 : 250.0,
//               curve: Curves.easeOut,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(30.0),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black26,
//                     spreadRadius: -10.0,
//                     blurRadius: 10.0,
//                     offset: Offset(0.0, 10.0),
//                   ),
//                 ],
//               ),
//               child: Stack(
//                 children: [
//                   AnimatedPositioned(
//                     duration: Duration(milliseconds: 375),
//                     top: 6.0,
//                     right: 7.0,
//                     curve: Curves.easeOut,
//                     child: AnimatedOpacity(
//                       opacity: (toggle == 0) ? 0.0 : 1.0,
//                       duration: Duration(milliseconds: 200),
//                       child: Container(
//                         padding: EdgeInsets.all(8.0),
//                         decoration: BoxDecoration(
//                           color: Color(0xffF2F3F7),
//                           borderRadius: BorderRadius.circular(30.0),
//                         ),
//                         child: AnimatedBuilder(
//                           child: Icon(
//                             Icons.close_rounded,
//                             size: 20.0,
//                           ),
//                           builder: (context, widget) {
//                             return Transform.rotate(
//                               angle: _con.value * 2.0 * pi,
//                               child: widget,
//                             );
//                           },
//                           animation: _con,
//                         ),
//                       ),
//                     ),
//                   ),
//                   AnimatedPositioned(
//                     duration: Duration(milliseconds: 375),
//                     left: (toggle == 0) ? 20.0 : 40.0,
//                     curve: Curves.easeOut,
//                     top: 11.0,
//                     child: AnimatedOpacity(
//                       opacity: (toggle == 0) ? 0.0 : 1.0,
//                       duration: Duration(milliseconds: 200),
//                       child: Container(
//                         height: 23.0,
//                         width: 180.0,
//                         child: TextField(
//                           controller: _textEditingController,
//                           cursorRadius: Radius.circular(10.0),
//                           cursorWidth: 2.0,
//                           cursorColor: Colors.black,
//                           decoration: InputDecoration(
//                             floatingLabelBehavior: FloatingLabelBehavior.never,
//                             labelText: 'Search...',
//                             labelStyle: TextStyle(
//                               color: Color(0xff5B5B5B),
//                               fontSize: 17.0,
//                               fontWeight: FontWeight.w500,
//                             ),
//                             alignLabelWithHint: true,
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20.0),
//                               borderSide: BorderSide.none,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Material(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(30.0),
//                     child: IconButton(
//                       splashRadius: 19.0,
//                       icon: Image.asset(
//                         'assets/search.png',
//                         height: 18.0,
//                       ),
//                       onPressed: () {
//                         setState(
//                           () {
//                             if (toggle == 0) {
//                               toggle = 1;
//                               _con.forward();
//                             } else {
//                               toggle = 0;
//                               _textEditingController.clear();
//                               _con.reverse();
//                             }
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dictionary/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/rounded_input_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

int toggle = 0;

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late StreamController _streamController;
  late Stream _stream;
  late AnimationController _con;
  TextEditingController _controller = TextEditingController();
  late Timer _debounce;

  late var lan = true; // true - romaji & japan, false - myanmar

  final FlutterTts tts = FlutterTts();

  @override
  void initState() {
    super.initState();
    print("HOME>>>>");
    _streamController = StreamController();
    _stream = _streamController.stream;

    _con = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 375),
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        toggle = 1;
        _con.forward();
      });
    });

    // _getData();
    tts.setLanguage('ja');
    tts.setSpeechRate(0.4);
    _getCloudData();
  }

  // List _items = [];

  // // Fetch content from the json file
  // Future<void> readJson() async {
  //   final String response = await rootBundle.loadString('data.json');
  //   final data = await json.decode(response);
  //   setState(() {
  //     _items = data["items"];
  //   });
  // }

  // _getData() async {
  //   final String response = await rootBundle.loadString('data.json');
  //   final data = await json.decode(response);
  //   print("JSON DATA>> ${data["items"]}");
  //   _streamController.add(data["items"]);
  // }

  _getCloudData() async {
    final prefs = await SharedPreferences.getInstance();
    final storedData = prefs.getString("stored_data") ?? "";
    print("SD>> $storedData");
    if (storedData != "") {
      List userData = json.decode(storedData);
      _streamController.add(userData);
    }

    final url = Uri.parse(
        'https://drive.google.com/uc?export=view&id=1LdFG9fEBi3TUTLiawVX2ghbWS8-qUvMI');
    final response = await http.get(url);
    // if (response.statusCode == 200) {
    final data = json.decode(utf8.decode(response.bodyBytes));
    prefs.setString("stored_data", json.encode(data["items"]));

    // _streamController.add(data["items"]);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  _search() async {
    if (_controller.text == null || _controller.text.length == 0) {
      _streamController.add(null);
      return;
    }

    _streamController.add("waiting");

    final prefs = await SharedPreferences.getInstance();
    List userData = json.decode(prefs.getString("stored_data")!);
    List outputList = userData
        .where((o) =>
            o['myanmar'].contains(_controller.text.trim()) ||
            o['japan'].contains(_controller.text.trim()) ||
            o['romaji'].contains(_controller.text.trim()) ||
            o['kanji'].contains(_controller.text.trim()))
        .toList();

    var english = RegExp(r'[a-zA-Z]');
    var japanese = RegExp(r'[\u3040-\u309F]');

    if (english.hasMatch(_controller.text.trim())) {
      lan = true;
    } else if (japanese.hasMatch(_controller.text.trim())) {
      lan = true;
    } else {
      lan = false;
    }

    _streamController.add(outputList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: selectColor,
        title: const Text("MJ Dictionary"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  // margin: const EdgeInsets.only(left: 12.0, bottom: 8.0),
                  // decoration: BoxDecoration(
                  //   // color: Colors.white,
                  //   borderRadius: BorderRadius.circular(24.0),
                  // ),
                  child:
                      // //  TextFormField(
                      // //   onChanged: (String text) {
                      // //     // if (_debounce?.isActive ?? false) _debounce.cancel();
                      // //     // _debounce = Timer(const Duration(milliseconds: 1000), () {
                      // //     _search();
                      // //     // });
                      // //   },
                      // //   controller: _controller,
                      // //   decoration: const InputDecoration(
                      // //     hintText: "Search for a word",
                      // //     contentPadding: EdgeInsets.only(left: 24.0),
                      // //     border: InputBorder.none,
                      // //   ),
                      // // ),
                      //     RoundedInputField(
                      //   hintText: "Search",
                      //   icon: Icons.phone,
                      //   // validator: (val) => Validator.validatePhone(val ?? ""),
                      //   onChanged: (val) {
                      //     setState(() {
                      //       // _key.currentState?.validate();
                      //       // userid = val;
                      //     });
                      //   },
                      //   controller: _controller,
                      // ),

                      /// --- New Search Bar -----

                      Container(
                    // height: 100.0,
                    // width: 250.0,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width,
                    alignment: const Alignment(-1.0, 0.0),
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      height: 48.0,
                      width: (toggle == 0)
                          ? 48.0
                          : MediaQuery.of(context).size.width,
                      curve: Curves.easeOut,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: const [
                           BoxShadow(
                            color: Colors.black26,
                            spreadRadius: -10.0,
                            blurRadius: 10.0,
                            offset: Offset(0.0, 10.0),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          AnimatedPositioned(
                            duration: const Duration(seconds: 5),
                            top: 6.0,
                            right: 7.0,
                            curve: Curves.easeOut,
                            child: AnimatedOpacity(
                              opacity: (toggle == 0) ? 0.0 : 1.0,
                              duration: const Duration(seconds: 3),
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: const Color(0xffF2F3F7),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: AnimatedBuilder(
                                  child: const Icon(
                                    Icons.close_rounded,
                                    size: 20.0,
                                  ),
                                  builder: (context, widget) {
                                    return Transform.rotate(
                                      angle: _con.value * 2.0 * pi,
                                      child: widget,
                                    );
                                  },
                                  animation: _con,
                                ),
                              ),
                            ),
                          ),
                          AnimatedPositioned(
                            duration: const Duration(seconds: 3),
                            left: (toggle == 0) ? 20.0 : 40.0,
                            curve: Curves.easeOut,
                            top: 11.0,
                            child: AnimatedOpacity(
                              opacity: (toggle == 0) ? 0.0 : 1.0,
                              duration: const Duration(seconds: 2),
                              child: Container(
                                height: 23.0,
                                width: 180.0,
                                child: TextField(
                                  controller: _controller,
                                  cursorRadius: const Radius.circular(10.0),
                                  cursorWidth: 2.0,
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    labelText: 'Search...',
                                    labelStyle: const TextStyle(
                                      color: Color(0xff5B5B5B),
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    alignLabelWithHint: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Material(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30.0),
                            child: IconButton(
                              splashRadius: 19.0,
                              icon: Image.asset(
                                'assets/search.png',
                                height: 18.0,
                              ),
                              onPressed: () {
                                // setState(
                                //   () {
                                //     if (toggle == 0) {
                                //       toggle = 1;
                                //       _con.forward();
                                //     } else {
                                //       toggle = 0;
                                //       _controller.clear();
                                //       _con.reverse();
                                //     }
                                //   },
                                // );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// /// --- End New Search Bar -----
                ),
              ),
              // IconButton(
              //   icon: const Icon(
              //     Icons.search,
              //     color: Colors.white,
              //   ),
              //   onPressed: () {
              //     _search();
              //   },
              // )
            ],
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(3.0),
        child: StreamBuilder(
          stream: _stream,
          builder: (BuildContext ctx, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: Text("Enter a search word"),
              );
            }

            if (snapshot.data == "waiting") {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.separated(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              // itemExtent: 50,
              padding: const EdgeInsets.all(0),
              itemCount: snapshot.data.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: 1),
              itemBuilder: (BuildContext context, int index) {
                // return Container(child: Text("ABC>>> ${snapshot.data.length}"),);
                return ListTile(
                  dense: true,
                  visualDensity:
                      const VisualDensity(vertical: -3), // to compact
                  onTap: () {
                    debugPrint("CLICK>> ${snapshot.data[index]}");
                  },
                  title: Text(
                    lan
                        ? snapshot.data[index]["japan"]
                        : snapshot.data[index]["myanmar"],
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    lan
                        ? snapshot.data[index]["myanmar"]
                        : snapshot.data[index]["japan"],
                    style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black54,
                        fontWeight: FontWeight.normal),
                  ),
                  trailing: GestureDetector(
                      onTap: () async {
                        debugPrint("Click Speak>>>");
                        await tts.speak("${snapshot.data[index]["japan"]}");
                        debugPrint("Click Speak Done>>>");
                      },
                      child: const Icon(
                        Icons.volume_down_alt,
                      )),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

// class LstTile extends StatelessWidget {
//   const LstTile({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       dense: true,
//       visualDensity: const VisualDensity(vertical: -3), // to compact
//       onTap: () {
//         debugPrint("CLICK>> ${snapshot.data[index]}");
//       },
//       title: Text(
//         lan ? snapshot.data[index]["japan"] : snapshot.data[index]["myanmar"],
//         style: const TextStyle(
//             fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
//       ),
//       subtitle: Text(
//         lan ? snapshot.data[index]["myanmar"] : snapshot.data[index]["japan"],
//         style: const TextStyle(
//             fontSize: 10, color: Colors.black54, fontWeight: FontWeight.normal),
//       ),
//     );
//   }
// }


// Expanded(
//                 child: Container(
//                   margin: const EdgeInsets.only(left: 12.0, bottom: 8.0),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(24.0),
//                   ),
//                   child:
//                       // //  TextFormField(
//                       // //   onChanged: (String text) {
//                       // //     // if (_debounce?.isActive ?? false) _debounce.cancel();
//                       // //     // _debounce = Timer(const Duration(milliseconds: 1000), () {
//                       // //     _search();
//                       // //     // });
//                       // //   },
//                       // //   controller: _controller,
//                       // //   decoration: const InputDecoration(
//                       // //     hintText: "Search for a word",
//                       // //     contentPadding: EdgeInsets.only(left: 24.0),
//                       // //     border: InputBorder.none,
//                       // //   ),
//                       // // ),
//                       RoundedInputField(
//                     hintText: "User Name/ Phone",
//                     icon: Icons.phone,
//                     // validator: (val) => Validator.validatePhone(val ?? ""),
//                     onChanged: (val) {
//                       setState(() {
//                         // _key.currentState?.validate();
//                         // userid = val;
//                       });
//                     },
//                     controller: _controller,
//                   ),
//                 ),
//               ),