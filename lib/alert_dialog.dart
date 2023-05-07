import 'package:dictionary/components/colors.dart';
import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String icon;
  final String title;
  final String subTitle;
  final String type;
  final String color;
  final String theme;

  ConfirmationDialog(
      {Key? key,
      required this.icon,
      required this.title,
      required this.subTitle,
      required this.type,
      required this.color,
      required this.theme})
      : super(key: key);
  // final String title;
  // final String subTitle;
  // ConfirmationDialog({this.title, this.subTitle});
  @override
  Widget build(
    BuildContext context,
  ) {
    // return Dialog(
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    //   elevation: 0,
    //   backgroundColor: Colors.transparent,
    //   child: _buildChild(context, icon, title, subTitle, type, color, theme),
    // );
    return WillPopScope(
      onWillPop: () {
        throw '';
      },
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
        contentPadding: EdgeInsets.all(0.0),
        // backgroundColor: Colors.transparent,
        backgroundColor: theme == "dark" ? darkBackColor : lightBackColor,
        // child: _buildChild(context, icon, title, subTitle, type, color, theme),
        content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return _buildChild(
              context, icon, title, subTitle, type, color, theme);
        }),
      ),
    );
  }

  _buildChild(
          BuildContext context, icon, title, subTitle, type, color, theme) =>
      // Container(
      //   height: icon == "" ? 160 : 280,
      //   decoration: BoxDecoration(
      //       // color: color == "blue"
      //       //     ? Colors.blue
      //       //     : color == "red" ? Colors.red : Colors.blue,
      //       color: theme == "dark" ? darkBackColor : lightBackColor,
      //       shape: BoxShape.rectangle,
      //       borderRadius: BorderRadius.all(Radius.circular(10))),
      //   child:
      Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          icon == ""
              ? Container()
              : Container(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Image.asset(
                      icon,
                      height: 110.0,
                      width: 110.0,
                    ),
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                  ),
                ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 22.0,
                // color: Colors.white,
                color: theme == "dark" ? lightTextColor : darkTextColor,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.0, left: 16.0),
            child: Text(
              subTitle,
              style: TextStyle(
                // color: Colors.white,
                color: theme == "dark" ? lightTextColor : darkTextColor,
                fontSize: 18.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          type == "1"
              ?
              // Row(
              //     mainAxisSize: MainAxisSize.min,
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     crossAxisAlignment: CrossAxisAlignment.end,
              //     children: <Widget>[
              Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: MaterialButton(
                      onPressed: () {
                        return Navigator.of(context).pop("Ok");
                      },
                      child: Text('OK',
                          style: TextStyle(
                            // color: theme == "dark"
                            //     ? lightTextColor
                            //     : darkTextColor,
                            // color: lightTextColor
                            fontWeight: FontWeight.bold,
                            color: color == "red"
                                ? Colors.red[300]
                                : Colors.lightBlue,
                          )),
                      textColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Colors.lightBlue,
                              // color: theme == "dark"
                              //     ? lightTextColor
                              //     : darkTextColor,
                              // color: lightTextColor,
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                  // MaterialButton(
                  //   onPressed: () {
                  //     return Navigator.of(context).pop("Ok");
                  //   },
                  //   child: Text(
                  //     "Ok",
                  //     style: TextStyle(
                  //         fontSize: 20.0, fontWeight: FontWeight.bold),
                  //   ),
                  //   // color: Colors.white,
                  //   textColor: Colors.white,
                  // ),
                )
              //   ],
              // )
              : type == "2"
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        // MaterialButton(
                        //   onPressed: () {
                        //     Navigator.of(context).pop();
                        //   },
                        //   child: Text(
                        //     "No",
                        //     style: TextStyle(
                        //       fontSize: 20.0,
                        //     ),
                        //   ),
                        //   textColor: Colors.white,
                        // ),
                        MaterialButton(
                          onPressed: () {
                            return Navigator.of(context).pop();
                          },
                          child: Text('NO',
                              style: TextStyle(
                                color: theme == "dark"
                                    ? lightTextColor
                                    : darkTextColor,
                                fontSize: 15,
                                // fontWeight: FontWeight.bold
                              )),
                          textColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: theme == "dark"
                                      ? lightTextColor
                                      : darkTextColor,
                                  // color: lightTextColor,
                                  width: 1,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(50)),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        // MaterialButton(
                        //   onPressed: () {
                        //     return Navigator.of(context).pop("Yes");
                        //   },
                        //   child: Text(
                        //     "Yes",
                        //     style: TextStyle(
                        //         fontSize: 20.0, fontWeight: FontWeight.bold),
                        //   ),
                        //   // color: Colors.white,
                        //   textColor: Colors.white,
                        // ),
                        MaterialButton(
                          onPressed: () {
                            return Navigator.of(context).pop("Yes");
                          },
                          child: Text('YES',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: color == "red"
                                    ? Colors.red[300]
                                    : Colors.lightBlue,
                                // theme == "dark"
                                //     ? lightTextColor
                                //     : darkTextColor,
                                fontSize: 15,
                                // fontWeight: FontWeight.bold
                              )),
                          textColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  // color: color == "red"
                                  //     ? Colors.red[300]
                                  //     : Colors.lightBlue,
                                  // theme == "dark"
                                  //     ? lightTextColor
                                  //     : darkTextColor,
                                  width: 1,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(50)),
                        ),
                      ],
                    )
                  : Container(),
          SizedBox(
            height: 15,
          ),
        ],
        // ),
      );
}
