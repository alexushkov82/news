import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:xml/xml.dart' as xml;
import 'package:xml/xml_events.dart';
import 'data.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';
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


  Future<List<Item>> getItemsFromXML(BuildContext context) async {
    // final url = Uri.parse('https://alfabank.ru/_/rss/_rss.html?subtype=1&category=2&city=21');
    // final request = await HttpClient().getUrl(url);
    // final HttpClientResponse response = await request.close();
    // final stringData = await response.transform(utf8.decoder).join();
    // print(stringData);
    // await response
    //     .transform(utf8.decoder)
        // .toXmlEvents()
        // .normalizeEvents()
        // .forEachEvent(onText: (event) => print(event.text));

    // return [];



    String xmlString = await DefaultAssetBundle.of(context).loadString('assets/data/data.xml');
    var raw = xml.parse(xmlString);
    var elements = raw.findAllElements('item');
    return elements.map((element){
      return Item(
        element.findElements('title').first.text,
        element.findElements('link').first.text,
        element.findElements('description').first.text,
        element.findElements('pubDate').first.text,
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
      body: FutureBuilder(
        future: getItemsFromXML(context),
        builder: (context, data) {
          if (data.hasData) {
            List<Item> items = data.data as List<Item>;
            return PageView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Scaffold(
                            appBar: AppBar(
                              title: const Text("Link"),
                            ),
                            body: WebView(
                              initialUrl: items[index].link,
                            ),
                          );
                          },
                      ),
                    );
                    },
                  child: itemCard(items[index]),
                );
                },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
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
        child: SingleChildScrollView(
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
      ),
    );
  }


}