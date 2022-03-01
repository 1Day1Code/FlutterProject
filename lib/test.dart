import 'package:flutter/material.dart';

// StatelessWidgetとは、State（状態）を持たないWidget
// StatefulWidgetとは、State（状態）を持つWidgetのことです。
// BuildContextとは親ウィジェットの状態や情報などの描画制御のための情報を管理しているコンテキストのことです。
class test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter'),
      ),
      body: Container(
        color: Colors.red,
      ),
    );
  }
}
