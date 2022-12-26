// Copyright 2021 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class NotationScreen extends StatefulWidget {
  NotationScreen({Key? key}) : super(key: key);

  @override
  State<NotationScreen> createState() => _NotationScreen();
}

class _NotationScreen extends State<NotationScreen> {
  late WebViewPlusController _controller;
  double _height = 1000;
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Stack(
            children: [
              WebViewPlus(
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: 'assets/web/hymn.html',
                onWebViewCreated: (controller) {
                  this._controller = controller;
                },
                onPageFinished: (url) {
                  // _controller.getHeight().then((double height) {
                  //   print("Height: " + height.toString());
                  // });
                  setState(() {
                    _isLoading = false;
                  });
                },
                javascriptChannels: {
                  JavascriptChannel(
                      name: 'JavascriptChannel',
                      onMessageReceived: (message) async {
                        await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Message from Javascript"),
                            content: Text(message.message),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                        //_controller.webViewController.runJavascript('start()');
                        // _controller.runJavascript("window.scrollTo({top: 0, behavior: 'smooth'});");
                      }),
                },
              ),
              (_isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Stack()),
            ],
          ),
        ),
      ],
    );
  }
}
