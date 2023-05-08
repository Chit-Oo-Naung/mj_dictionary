import 'package:flutter/material.dart';

import 'components/colors.dart';

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

class _KanjiPageState extends State<KanjiPage> {
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
                height: 60,
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
                        // _showUnitActionSheet(context);
                      },
                      child: Row(
                        children: [
                          Text(
                            "Kanji",
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

              //
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 13.0, left: 0, right: 0),
                  child: Column(
                    children: [],
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
