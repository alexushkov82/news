import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/main.dart';
import 'data.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as devtools show log;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: PageView(
        controller: _controller,
        children: [
          Page1(),
          Page2(),
          Page3(),
        ],
      ),
    );
  }

  Widget Page1() {
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
              'One',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed'
                  ' do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
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

  Widget Page2() {
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
              'Two',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed'
                  ' do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
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

  Widget Page3() {
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
              'Three',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed'
                  ' do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
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