import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mjdictionary/components/colors.dart';
import 'package:mjdictionary/components/gradient_text.dart';
import 'package:mjdictionary/utils/colors_util.dart';

class GrammarFormPage extends StatefulWidget {
  final String title;
  final String htmlData;
  const GrammarFormPage({Key? key, required this.title, required this.htmlData})
      : super(key: key);

  @override
  _GrammarFormPageState createState() => _GrammarFormPageState();
}

class _GrammarFormPageState extends State<GrammarFormPage> {
  // String htmlData = "<h3><span style='color:#c0392b'><strong>どうし１</strong></span></h3><ul><li><span style='font-size:14px'><span style='color:#c0392b'><strong>ます</strong></span> ရဲ့အရှေ့မှာ <span style='color:#c0392b'><strong>い</strong></span> လိုင်းနဲ့ဆုံးထားရင်</span></li></ul><p>&nbsp;</p><h3><span style='color:#c0392b'><strong>どうし２</strong></span></h3><ul><li><span style='font-size:14px'><span style='color:#c0392b'><strong>ます</strong></span> ရဲ့အရှေ့မှာ <span style='color:#c0392b'><strong>え</strong></span>&nbsp;လိုင်းနဲ့ဆုံးထားရင်</span></li><li><span style='font-size:14px'>တစ်လုံးထဲ Verb များ (きます - လာသည်မှလွဲ၍)</span></li><li><span style='font-size:14px'>ချွင်းချက် Verb များ</span><ol><li><span style='font-size:14px'>あきます　　　ー　ငြီးငွေ့သည်</span></li><li><span style='font-size:14px'>かんじます　　ー　ခံစားရသည်</span></li><li><span style='font-size:14px'>かります　　　ー　ချေးယူသည်</span></li><li><span style='font-size:14px'>あびます　　　ー　ရေချိုးသည်</span></li><li><span style='font-size:14px'>おちます　　　ー　ပြုတ်ကျသည်</span></li><li><span style='font-size:14px'>できます　　　ー　လုပ်နိုင်သည်</span></li><li><span style='font-size:14px'>おります　　　ー　ဆင်းသည်</span></li><li><span style='font-size:14px'>おきます　　　ー　အိပ်ယာထသည်</span></li><li><span style='font-size:14px'>すぎます　　　ー　ကျော်လွန်သည်</span></li><li>&nbsp;たります　　　 ー　လုံလောက်သည်</li><li>&nbsp;いきます　　　 ー　အသက်ရှင်နေ&zwnj;ထိုင်သည်　　　</li></ol></li></ul><h3><span style='color:#c0392b'><strong>どうし３</strong></span></h3><ul><li><span style='color:#c0392b'><span style='font-size:14px'><strong>きます　</strong></span></span><span style='font-size:14px'>ー　လာသည်</span></li><li><span style='color:#c0392b'><span style='font-size:14px'><strong>します　</strong></span></span><span style='font-size:14px'>ー　လုပ်သည်</span></li><li><span style='font-size:14px'>​​​​​​​တစ်ခြား どうし３ခွဲနည်း</span><ul><li><span style='font-size:14px'>します ရဲ့ရှေ့မှာ ３ or ３လုံးအထက်ရှိရင်</span></li><li><span style='font-size:14px'>かたがな နဲ့ します နဲ့ပေါင်းရင်</span></li><li><span style='font-size:14px'>Noun နဲ့ します ကိုစုလို့ပေါင်းလို့ရ (အဓိပ္ပာယ်တူရင်)</span></li></ul></li></ul>";
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
                        "${widget.title}",
                        style: TextStyle(
                          fontSize: 19.0,
                          fontWeight: FontWeight.bold,
                        ),
                        gradient: LinearGradient(colors: [
                          Colors.black,
                          secondaryColor,
                        ]),
                      ),
                      Container()
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                      padding:
                          const EdgeInsets.only(top: 40.0, left: 0, right: 0),
                      child: Html(data: "${widget.htmlData}")),
                )
              ],
            ),
          ],
        ));
  }
}
