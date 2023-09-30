import 'package:flutter/material.dart';

var firstTime = true;
var kaiwaFirstTime = true;

List levelList = [];
// List lessonsList = [];

addLevel(List list) {
  levelList = groupJSONByUniqueKey(list, "level");
  debugPrint("LEVEL LIST >>> $levelList");
}

getLessons(List list, level) {
  List outputList = list.where((o) => o['level'].contains(level)).toList();
  // debugPrint("LESSON LIST >>> $level ||| $outputList ");
  return groupJSONByUniqueKey(outputList, "lesson");
}

getKanjiLessons(List list, level) {
  List outputList = list.where((o) => o['level'].contains(level) && o['type'].contains("kanji")).toList();
  // debugPrint("LESSON LIST >>> $level ||| $outputList ");
  return groupJSONByUniqueKey(outputList, "lesson");
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
