import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mjdictionary/components/colors.dart';
import 'package:mjdictionary/components/gradient_text.dart';
import 'package:mjdictionary/grammar_form.dart';

class GrammarFormListPage extends StatefulWidget {
  const GrammarFormListPage({Key? key}) : super(key: key);

  @override
  _GrammarFormListPageState createState() => _GrammarFormListPageState();
}

class _GrammarFormListPageState extends State<GrammarFormListPage> {
  List grammarList = [
    {
      "title": "どうし",
      "new": "",
      "html":
          "<h3><span style='color:#c0392b'><strong>どうし１</strong></span></h3><ul><li><span style='font-size:14px'><span style='color:#c0392b'><strong>ます</strong></span> ရဲ့အရှေ့မှာ <span style='color:#c0392b'><strong>い</strong></span> လိုင်းနဲ့ဆုံးထားရင်</span></li></ul><p>&nbsp;</p><h3><span style='color:#c0392b'><strong>どうし２</strong></span></h3><ul><li><span style='font-size:14px'><span style='color:#c0392b'><strong>ます</strong></span> ရဲ့အရှေ့မှာ <span style='color:#c0392b'><strong>え</strong></span>&nbsp;လိုင်းနဲ့ဆုံးထားရင်</span></li><li><span style='font-size:14px'>တစ်လုံးထဲ Verb များ (きます - လာသည်မှလွဲ၍)</span></li><li><span style='font-size:14px'>ချွင်းချက် Verb များ</span><ol><li><span style='font-size:14px'>あきます　　　ー　ငြီးငွေ့သည်</span></li><li><span style='font-size:14px'>かんじます　　ー　ခံစားရသည်</span></li><li><span style='font-size:14px'>かります　　　ー　ချေးယူသည်</span></li><li><span style='font-size:14px'>あびます　　　ー　ရေချိုးသည်</span></li><li><span style='font-size:14px'>おちます　　　ー　ပြုတ်ကျသည်</span></li><li><span style='font-size:14px'>できます　　　ー　လုပ်နိုင်သည်</span></li><li><span style='font-size:14px'>おります　　　ー　ဆင်းသည်</span></li><li><span style='font-size:14px'>おきます　　　ー　အိပ်ယာထသည်</span></li><li><span style='font-size:14px'>すぎます　　　ー　ကျော်လွန်သည်</span></li><li>&nbsp;たります　　　 ー　လုံလောက်သည်</li><li>&nbsp;いきます　　　 ー　အသက်ရှင်နေ&zwnj;ထိုင်သည်　　　</li></ol></li></ul><h3><span style='color:#c0392b'><strong>どうし３</strong></span></h3><ul><li><span style='color:#c0392b'><span style='font-size:14px'><strong>きます　</strong></span></span><span style='font-size:14px'>ー　လာသည်</span></li><li><span style='color:#c0392b'><span style='font-size:14px'><strong>します　</strong></span></span><span style='font-size:14px'>ー　လုပ်သည်</span></li><li><span style='font-size:14px'>​​​​​​​တစ်ခြား どうし３ခွဲနည်း</span><ul><li><span style='font-size:14px'>します ရဲ့ရှေ့မှာ ３ or ３လုံးအထက်ရှိရင်</span></li><li><span style='font-size:14px'>かたがな နဲ့ します နဲ့ပေါင်းရင်</span></li><li><span style='font-size:14px'>Noun နဲ့ します ကိုစုလို့ပေါင်းလို့ရ (အဓိပ္ပာယ်တူရင်)</span></li></ul></li></ul>"
    },
    {
      "title": "てけい",
      "new": "",
      "html":
          "<h3><span style='color:#c0392b'><strong>てけい (～V၍/～Vပြီး)</strong></span></h3><p><span style='font-size:14px'><strong><span style='color:#c0392b'>Group 1</span></strong></span></p><ul><li><span style='font-size:14px'><strong>い、ち、り</strong><strong>　➞　って</strong></span></li><li><span style='font-size:14px'><strong>み、に、び　➞　んで</strong></span></li><li><span style='font-size:14px'><strong>き　　　　　➞　いて</strong></span></li><li><span style='font-size:14px'><strong>ぎ　　　　　➞　いで</strong></span></li><li><span style='font-size:14px'><strong>し　　　　　➞　しで</strong></span></li></ul><p>　　<span style='font-size:14px'>ဥပမာ&nbsp; &nbsp; &nbsp; &nbsp;- <strong>かいます　➞　かって</strong></span></p><p><span style='font-size:14px'>　　ချွင်းချက်&nbsp; - <strong>いきます　➞　いって</strong></span></p><p><span style='font-size:14px'><strong><span style='color:#c0392b'>Group 2</span></strong></span></p><ul><li><span style='font-size:14px'><span style='color:#c0392b'><strong>ます</strong></span>　ဖြုတ်　<span style='color:#c0392b'><strong>て</strong></span>　ပေါင်း</span></li></ul><p><span style='font-size:14px'><strong><span style='color:#c0392b'>Group 3</span></strong></span></p><ul><li><strong>きます　➞　きて</strong></li><li><strong>します　➞　して</strong></li></ul>"
    },
    {
      "title": "たけい",
      "new": "",
      "html":
          "<h3><span style='color:#c0392b'><strong>たけい （V+ました）</strong></span></h3><p><span style='font-size:14px'><strong><span style='color:#c0392b'>Group 1</span></strong></span></p><ul><li><span style='font-size:14px'><strong>い、ち、り</strong><strong>　➞　った</strong></span></li><li><span style='font-size:14px'><strong>み、に、び　➞　んだ</strong></span></li><li><span style='font-size:14px'><strong>き　　　　　➞　いた</strong></span></li><li><span style='font-size:14px'><strong>ぎ　　　　　➞　いだ</strong></span></li><li><span style='font-size:14px'><strong>し　　　　　➞　しだ</strong></span></li></ul><p>　　<span style='font-size:14px'>ဥပမာ&nbsp; &nbsp; &nbsp; &nbsp;- <strong>かいます　➞　かった</strong></span></p><p><span style='font-size:14px'>　　ချွင်းချက်&nbsp; - <strong>いきます　➞　いった</strong></span></p><p><span style='font-size:14px'><strong><span style='color:#c0392b'>Group 2</span></strong></span></p><ul><li><span style='font-size:14px'><span style='color:#c0392b'><strong>ます</strong></span>　ဖြုတ်　<span style='color:#c0392b'><strong>た</strong></span>　ပေါင်း</span></li></ul><p><span style='font-size:14px'><strong><span style='color:#c0392b'>Group 3</span></strong></span></p><ul><li><strong>きます　➞　きた</strong></li><li><strong>します　➞　した</strong></li></ul>"
    }
  ];

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
                        "Grammar Forms",
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
                    child: ListView.builder(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      // itemExtent: 50,
                      padding: const EdgeInsets.all(0),
                      itemCount: grammarList.length,
                      // separatorBuilder: (BuildContext context, int index) =>
                      //     const Divider(color: Colors.amberAccent,),
                      itemBuilder: (BuildContext context, int index) {
                        // return Container(child: Text("ABC>>> ${snapshot.data.length}"),);
                        return Container(
                          padding: const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                              color: index % 2 == 0
                                  ? Colors.white
                                  : Colors.amber[50]),
                          child: ListTile(
                            dense: true,
                            visualDensity:
                                const VisualDensity(vertical: 2), // to compact
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return GrammarFormPage(
                                  title: grammarList[index]["title"],
                                  htmlData: grammarList[index]["html"],
                                );
                              }));
                            },
                            title: Text(
                              grammarList[index]["title"],
                              style: const TextStyle(
                                  fontSize: 18,
                                  // color: Color.fromARGB(255, 6, 111, 134),
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Icon(
                              Icons.keyboard_arrow_right_rounded,
                              size: 32,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
