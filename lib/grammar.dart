import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mjdictionary/components/colors.dart';
import 'package:mjdictionary/components/gradient_text.dart';

class GrammarPage extends StatefulWidget {
  const GrammarPage({Key? key}) : super(key: key);

  @override
  _GrammarPageState createState() => _GrammarPageState();
}

class _GrammarPageState extends State<GrammarPage> {

  String htmlData = "<h3><span style='font-size:14px'>​​​​​​<span style='color:#c0392b'><strong>～んです。（～လို့ပါ）「အကြောင်းပြချက်၊ အလေးအနက်ပြောတဲ့နေရာမှာသုံး」</strong></span></span></h3><ul><li><span style='font-size:14px'><strong>Verb/いAdj　 ➞　PlainForm + <span style='color:#c0392b'>んです</span></strong></span></li><li><span style='font-size:14px'><strong>なAdj/Noun　➞　PlainForm <span style='color:#c0392b'>だ</span> ဖြုတ် + <span style='color:#c0392b'>んです</span></strong></span></li><li><span style='font-size:14px'><strong>1) ～んですか。　2) ～んですが、</strong></span><br />&nbsp;</li></ul><ol><li><span style='font-size:14px'>どうしておくれたんですか。</span><br />ဘာလို့နောက်ကျတာလဲ။<br />バスがこながったんです。<br />ဘတ်စ်ကားမလာလို့ပါ။</li><li>どうしたんですか。<br />ဘာဖြစ်လို့လဲ။<br />ちょっときぶんがわるいんです。<br />နေလို့သိပ်မကောင်းလို့ပါ။<br />&nbsp;</li></ol><p><span style='font-size:14px'><span style='color:#c0392b'><strong>Vて + いただけませんか。(Vပေးလို့ရနိုင်မလား)</strong></span></span><br /><span style='color:#c0392b'><span style='font-size:16px'><strong>​​​</strong></span></span></p><ol><li><span style='font-size:14px'>いいせんせいをしょうかいしていただけませんか。<br />ဆရာကောင်းကောင်းလေးမိတ်ဆက်ပေးလို့ရမလား။</span><br />&nbsp;</li></ol><p><span style='font-size:14px'>​​​​​​​​​​​​​​​​​​​​​</span><span style='color:#c0392b'><span style='font-size:16px'><strong><span style='font-size:14px'>Vた + らいいですか。(ရင်ကောင်းမလဲ) 「အကြံအဉာဏ်တောင်းတဲ့နေရာမှာသုံး」</span></strong></span></span></p><ol><li><span style='font-size:14px'><span style='color:#c0392b'>​​​​​​​</span>どこでカメラをかったらいいですか。<br />ဘယ်မှာကင်မရာကိုဝယ်ရင်ကောင်းမလဲ။</span></li><li><span style='font-size:14px'>こまがいおかねが、どうしたらいいですか。<br />ပိုက်ဆံအကြွေမရှိလို့ပါ, ဘယ်လိုလုပ်ရင်ကောင်းမလဲ။</span></li></ol>";

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
                        "Grammar",
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
                Expanded(
                  child: Padding(
                      padding:
                          const EdgeInsets.only(top: 40.0, left: 0, right: 0),
                      child: Html(data: htmlData)),
                )
              ],
            ),
          ],
        ));
  }
}
