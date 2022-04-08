import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:xml/xml.dart' as xml;
import 'package:http/http.dart' as http;
import 'package:windows1251/windows1251.dart';
import 'package:html_unescape/html_unescape.dart';
import 'data.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:developer' as devtools show log;
import 'dart:async';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var unescape = HtmlUnescape();

  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  final PageController _controller = PageController(
    initialPage: 0,
  );

  Future<List<Item>> getItemsFromXML(BuildContext context) async {
    try {
      final url = Uri.parse('https://alfabank.ru/_/rss/_rss.html?subtype=1&category=2&city=21');
      Map<String, String> headers = {"Content-Type": "text/html,application/xml; charset=utf-8"};
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final document = xml.XmlDocument.parse(windows1251.decode(response.bodyBytes));
        var xmlParsedFile = document
            .findAllElements('item')
            .map<Item>((e) => Item.fromElement(e))
            .toList();
        return xmlParsedFile;
      } else {
        return throw Exception('Failed to load');
      }
    } catch(e) {
      devtools.log(e.toString());
      return [];
    }
    /*
    String file = await DefaultAssetBundle.of(context).loadString('assets/data/data.xml');
    var document = xml.XmlDocument.parse(file);
    var xmlParsedFile = document
        .findAllElements('item')
        .map<Item>((e) => Item.fromElement(e))
        .toList();
    return xmlParsedFile;
    */
  }

  @override
  void initState() {
    Timer.periodic(const Duration(minutes: 5), (Timer timer) {
      setState(() {});
    });
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onRefresh() async{
    setState(() {
    });
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: FutureBuilder(
        future: getItemsFromXML(context),
        builder: (BuildContext context, AsyncSnapshot data) {
          if (data.hasData) {
            List<Item> items = data.data as List<Item>;
            FlutterNativeSplash.remove();
            return SmartRefresher(
              physics: BouncingScrollPhysics(),
              onRefresh: _onRefresh,
              controller: _refreshController,
              child: ListView.builder(
                //physics: BouncingScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return  Scaffold(
                              appBar: AppBar(
                                title: const Text("News"),
                              ),
                              body: itemNews(items[index]),
                            );
                          },
                        ),
                      );
                    },
                    child: itemCard(items[index]),
                  );
                }
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget itemCard(Item item) {
    return SizedBox(
      height: 300,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Text(
                item.title,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: Text(
                  unescape.convert(item.description),
                  overflow: TextOverflow.fade,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget itemNews(Item item) {
    return PageView(
      children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    unescape.convert(item.description),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        WebView(
          initialUrl: item.link,
        )
      ],
    );
  }


  

}