import 'dart:convert';
import 'package:xml/xml.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:xml/xml.dart' as xml;

class Item {
  String title;
  String link;
  List<String> description;
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
    List<String> description = [element.findElements('description').single.text];
    return Item(
      title: /*unhtml.convert(element
          .findElements('title')
          .single
          .text),*/
      element
          .findElements('title')
          .single
          .text,
      link: element
        .findElements('link')
        .single
        .text,
      description: description,
      date: element
          .findElements('pubDate')
          .single
          .text,
      guid: element
          .findElements('guid')
          .single
          .text,
    );

  }

}