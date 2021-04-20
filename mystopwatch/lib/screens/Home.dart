import 'dart:async';

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String textShow = "00:00:00";
  bool iStop = true;
  Timer _timer;
  List<int> listResult = [];
  // microseconds
  int _start = 0;
  String convertMicrosecon(int time) {
    int second = ((time ~/ 1000)) % 60;
    int minute = ((time ~/ 60000)) % 60;
    int hour = (time ~/ (60000 * 60));
    return "$hour:$minute:$second";
  }

  void startTimer() {
    const oneSec = const Duration(milliseconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (iStop == true) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start++;
            textShow = convertMicrosecon(_start);
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Padding(padding: const EdgeInsets.only(top: 30)),
            Text(
              textShow,
              style: TextStyle(color: Colors.red, fontSize: 30),
            ),
            Padding(padding: const EdgeInsets.only(top: 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: 80, height: 80),
                  child: ElevatedButton(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.red[900],
                    ),
                    onPressed: () {
                      iStop = false;
                      startTimer();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.brown[100],
                      shape: CircleBorder(),
                    ),
                  ),
                ),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 20)),
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: 80, height: 80),
                  child: ElevatedButton(
                    child: Icon(
                      Icons.stop,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      iStop = true;
                      listResult.add(_start);
                      // startTimer();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.brown[100],
                      shape: CircleBorder(),
                    ),
                  ),
                ),
              ],
            ),
            Padding(padding: const EdgeInsets.only(top: 10)),
            Expanded(
              child: DraggableScrollableSheet(builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  color: Colors.white,
                  child: ListView.builder(
                      controller: scrollController,
                      itemCount: listResult.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            title: Text(
                                ' ${convertMicrosecon(listResult[index])}'));
                      }),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
