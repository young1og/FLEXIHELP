import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FaqPage extends StatefulWidget {
  @override
  _FaqPageState createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  final _faqs = {
    'What is this app for?':
    'This app provides a variety of features, controls and device customization that will help you, adapt your device to your lifestyle',
    'How do I use this app?':
    'This application is designed to be easy to use. You can find a quick guide on our website',
    'Where can I find more information?':
    'You can find more information on our website',
    'How can I find your website?':
    'You can go to our website from the Connect page by scanning the QR code, or just click on the button below it',
  };

  bool _isExpanded(String question) => _expandedQuestion == question;
  String? _expandedQuestion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FAQ',
          style: TextStyle(color: Colors.white), // White text for better contrast
        ),
        backgroundColor: Colors.lightBlueAccent,
        elevation: 0.0, // Remove app bar shadow for a cleaner look
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlueAccent, Colors.lightBlue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _faqs.length,
          itemBuilder: (context, index) {
            final question = _faqs.keys.elementAt(index);
            final answer = _faqs[question];

            return _buildFaqCard(context, question, answer);
          },
        ),
      ),
    );
  }

  Widget _buildFaqCard(BuildContext context, String question, String? answer) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300), // Animation duration
      curve: Curves.easeInOut, // Smoother animation curve
      child: Card(
        elevation: _isExpanded(question) ? 4.0 : 2.0, // Adjust elevation on expansion
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: ExpansionTile(
          title: Text(
            question,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _isExpanded(question) ? Colors.blue : Colors.black, // Change text color on expansion
            ),
          ),
          children: [
            if (answer != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  answer,
                  style: TextStyle(fontSize: 16),
                ),
              ),
          ],
          initiallyExpanded: _isExpanded(question),
          onExpansionChanged: (isExpanded) => setState(() => _expandedQuestion = isExpanded ? question : null),
        ),
      ),
    );
  }
}
