import 'package:flutter/material.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:xml/xml.dart' as xml;
import 'data.dart';
import 'dart:developer' as devtools show log;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final PageController _controller = PageController(
    initialPage: 0,
  );

  Future<List<Item>> getContactsFromXML(BuildContext context) async {
    String xmlString = await DefaultAssetBundle.of(context).loadString('');
    var raw = xml.parse(xmlString);
    var elements = raw.findAllElements('item');
    return elements.map((element){
      return Item(
        element.findElements('title').first.text,
        element.findElements('link').first.text,
        element.findElements('description').first.text,
        element.findElements('date').first.text,
        element.findElements('guid').first.text,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: PageView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: Item.samples.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return WebView(
                      initialUrl: Item.samples[index].link,
                    );
                  },
                ),
              );
            },
            child: itemCard(Item.samples[index]),
          );
        },
      ),
    );
  }

  Widget itemCard(Item item) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Text(
              item.title,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              item.description,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }


}