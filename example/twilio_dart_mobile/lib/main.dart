import 'package:flutter/material.dart';
import 'package:twilio_dart/twilio.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twilio Dart Mobile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Twilio Dart Mobile'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Twilio twilio;
  bool _isSended = false;
  String errorMessage;

  void _sendMessage() async {
    // Send SMS for LOLZ
    var from = "your_twilio_phone";
    var to = "your_mobile_number";
    var body = "Look ma! Dart can now send SMS's in under 15 lines";

    try {
      var result = await twilio.sendSMS(from, to, body);
      print(result);
      _isSended = true;
    } catch (error) {
      print(error);
      errorMessage = error.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    var key = "your_twilio_key";
    var authToken = "your_auth_token";
    var version = "2010-04-01";
    //create a new twillio object
    twilio = new Twilio(key, authToken, version);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Message someone!',
            ),
            RaisedButton(
              child: Text("Press me to send a text"),
              onPressed: _sendMessage,
              highlightElevation: 16.0,
              highlightColor: Colors.blue,
            ),
            Visibility(
              child: Text('Your message has been sent!'),
              visible: _isSended,
            ),
            Visibility(
              child: Text('$errorMessage'),
              visible: errorMessage != null,
            ),
          ],
        ),
      ),
    );
  }
}
