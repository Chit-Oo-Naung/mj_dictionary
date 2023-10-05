import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mjdictionary/components/colors.dart';
import 'package:mjdictionary/components/gradient_text.dart';

class TranslatePage extends StatefulWidget {
  const TranslatePage({Key? key}) : super(key: key);

  @override
  _TranslatePageState createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> {
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
                        child: const Icon(
                          Icons.arrow_back_rounded,
                          color: Color.fromARGB(255, 137, 37, 37),
                        ),
                      ),
                      GradientText(
                        "Translate",
                        style: TextStyle(
                          fontSize: 19.0,
                          fontWeight: FontWeight.bold,
                        ),
                        gradient: LinearGradient(colors: [
                          Colors.black,
                          Color.fromARGB(255, 137, 37, 37),
                        ]),
                      ),
                      Container()
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 0, right: 0),
                child: InAppWebView(
                  initialUrlRequest: URLRequest(
                    url: Uri.parse(
                      "https://translate.google.com/?hl=my&sl=ja&tl=my&op=translate",
                    ),
                  ),
                  initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                      javaScriptEnabled: true,
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
