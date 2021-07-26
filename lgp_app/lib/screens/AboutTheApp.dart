import 'package:flutter/material.dart';
import '../models/screen_data.dart';

class AboutTheApp extends StatefulWidget {
  @override
  _AboutTheAppState createState() => _AboutTheAppState();
}

class _AboutTheAppState extends State<AboutTheApp> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        title: Text("About the App",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset(
              "assets/images/about_us.png",
              fit: BoxFit.contain,
              height: size.height * 0.30,
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "This app is brought to your by Titus Ng and Roy Chua.",
                style: TextStyle(fontFamily: "Circular", fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                "Created as part of our Orbital Project in NUS. Through our experiences in physiotheraphy and the outdated methods of record collection for patients and physiotherapists, we decided to make and application that is able to serve this need. We hope this application is able to make the recovery process more seamless for the patients and the physiotherapists. Thank you for using Let's Get Physiocal.",
                style: TextStyle(fontFamily: "Circular", fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
