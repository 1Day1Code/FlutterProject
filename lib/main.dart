import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepOrange,
      ),
      home: const MyHomePage(title: 'Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _zero = 0;
  List<Map> _content = [];
  List movies = [
    {'title': '鬼滅の刃', 'box_office': '390.0'},
    {'title': '千と千尋の神隠し', 'box_office': '316.8'},
    {'title': 'タイタニック', 'box_office': '262.0'},
    {'title': 'アナと雪の女王', 'box_office': '255.0'},
    {'title': '君の名は。', 'box_office': '250.3'},
    {'title': 'ハリー・ポッターと賢者の石', 'box_office': '203.3'},
    {'title': 'もののけ姫', 'box_office': '201.8'},
    {'title': 'ハウルの動く城', 'box_office': '196.0'},
    {'title': '踊る大捜査線 THE MOVIE 2 レインボーブリッジを封鎖せよ!', 'box_office': '173.5'},
    {'title': 'ハリー・ポッターと秘密の部屋', 'box_office': '173.0'},
    {'title': 'アバター', 'box_office': '156.0'},
  ];
  final items = List<String>.generate(10, (i) => "Item $i");
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      // _counter++;
      final list = [0, 1, 2];
      list.forEach((v) => print(v));
      _zero = _zero + 10;
      print(_zero);
    });
  }

  void showDailog() {}

  void _request() async {
    http.Response resp = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));
    if (resp.statusCode != 200) {
      setState(() {
        int statusCode = resp.statusCode;
      });
      return;
    }
    setState(() {
      var item = convert.jsonDecode(resp.body) as Map<String, dynamic>;
      print(item);
      _content.add(item);
    });
  }

  void _postRequest() async {
    Map<String, String> headers = {'content-type': 'application/json'};
    String body = convert.jsonEncode(
        {'title': "a1 test", 'body': "this is test by a1", 'userId': 1});
    http.Response resp = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/'),
        headers: headers,
        body: body);
    if (resp.statusCode != 201) {
      setState(() {
        int statusCode = resp.statusCode;
      });
      return;
    }
    setState(() {
      var item = convert.jsonDecode(resp.body) as Map<String, dynamic>;
      print(item);
      // var item = convert.jsonDecode(resp.body) as Map<String, dynami
      _request();
      // _content.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        //ここでは、によって作成されたMyHomePageオブジェクトから値を取得します
        // App.buildメソッドを使用して、アプリバーのタイトルを設定します。
        title: Text(widget.title),
        actions: <Widget>[
          Icon(Icons.add),
          Icon(Icons.share),
        ],
      ),
      body: ListView.builder(
        itemCount: _content.length, // _contentの長さだけ表示
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(_content[index]['title']),
              trailing: IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text(_content[index]['title']),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _postRequest,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
