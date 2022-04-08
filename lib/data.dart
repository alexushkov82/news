import 'package:flutter/material.dart';
import 'package:xml/xml.dart';
import 'package:xml/xml.dart' as xml;

class Item {
  String title;
  String link;
  String description;
  String date;
  String guid;

  Item({
    required this.title,
    required this.link,
    required this.description,
    required this.date,
    required this.guid,
  });

  @override
  String toString() {
    return title + '\n' + link + '\n' + description.toString()  + '\n' + date + '\n' + guid;
  }

  factory Item.fromElement(XmlElement element) {
    String tmp = element.findElements('description').single.text;
    return Item(
      title: element.findElements('title').single.text,
      link: element.findElements('link').single.text,
      description: tmp.replaceAll(RegExp(r'<p>|</p>|<img.*/>|<br/>|<a.*/a>|<b>|</b>'), ''),
      date: element.findElements('pubDate').single.text,
      guid: element.findElements('guid').single.text,
    );

  }



}