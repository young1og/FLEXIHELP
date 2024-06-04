import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ConnectVideoAudioPage extends StatefulWidget {
  @override
  _ConnectVideoAudioPageState createState() => _ConnectVideoAudioPageState();
}

class _ConnectVideoAudioPageState extends State<ConnectVideoAudioPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward(); // Start the animation on page load
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildUsbIcon(BuildContext context) {
    return Center(
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Icon(
          Icons.usb,
          size: 40,
          color: Colors.blueAccent,
        ),
      ),
    );
  }

  Widget _buildCategoryIcon(BuildContext context, IconData icon, String label, Color color) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.lightBlueAccent.withOpacity(0.2),
          child: Icon(
            icon,
            size: 40,
            color: color,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          label,
          style: TextStyle(fontSize: 16, color: color),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Connect Video or Audio',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightBlueAccent,
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.grey[200],
        child: Center(
          child: FadeTransition(
            opacity: _opacityAnimation,
            child: Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Instructions',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Insert a flash drive into the USB port',
                      style: TextStyle(fontSize: 18, color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.0),
                    _buildUsbIcon(context),
                    SizedBox(height: 16.0),
                    Text(
                      'Choose the folder and the media you would like to play',
                      style: TextStyle(fontSize: 18, color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildCategoryIcon(context, FontAwesomeIcons.bookOpen, 'Books', Colors.black87),
                        _buildCategoryIcon(context, FontAwesomeIcons.images, 'Photos', Colors.black87),
                        _buildCategoryIcon(context, FontAwesomeIcons.playCircle, 'Videos', Colors.black87),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
