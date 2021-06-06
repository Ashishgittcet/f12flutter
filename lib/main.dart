import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
void main(){
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  var data = 'Ashish';
  final url="https://rathi.com/TradeMobiServices_V3/api/GetToken/TokenKey";
  StreamController<bool> _streamController = StreamController.broadcast();
  Future <void> postData()  async{
    try {
      final response = await post(Uri.parse(url), body: {
        "ClientID":"HOIBA193",
        "BusinessID":"Rupeeseed"
      });
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        data= jsonResponse[0]['access_token'];
        print(response.body);
        if(data != null && data != ''){
          _streamController.add(true);
        }else{
          _streamController.add(true);
        }
        print('Number of country about http: $data.');
      } else {
        _streamController.add(false);
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch(er){}
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter WebView '),
        ),
        body: Column(
          children: <Widget>[
            StreamBuilder<bool>(
                stream: _streamController.stream,
                builder: (context, snapshot) {
                  return Text(data);
                }
            ),
            RaisedButton(child: Text("Fetch Post"),
                onPressed: () => {
                  postData()
                }),
          ],
        ),
      ),
    );
  }
}