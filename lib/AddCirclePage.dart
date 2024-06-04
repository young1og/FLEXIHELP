import 'package:flexihelp/main.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AddCirclePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connect'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.lightBlueAccent,
              Colors.lightBlue,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Connecting the device',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 16.0),
            Text(
              'Visit the website by scanning the QR-code or clicking on the button, on the website you can choose the device according to your preferences',
              style: TextStyle(fontSize: 16.0, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.0),
            Image.asset(
              'assets/qr_code.jpg', // Укажите путь к реальному QR-коду
              width: 200,
              height: 200,
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () async {
                const url = 'https://milenkiy.github.io/FlexiHelp/';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: Text(
                'Visit Website to Purchase Device',
                style: TextStyle(fontSize: 16.0),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.lightBlueAccent, backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
