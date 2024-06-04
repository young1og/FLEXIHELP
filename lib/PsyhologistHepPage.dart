import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PsychologistHelperPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mobile Psychologist Helper AI'),
        backgroundColor: Colors.lightBlue[200], // Teal background color
        elevation: 4.0, // Add elevation for the app bar
      ),
      body: Container(
        color: Colors.lightBlue[200], // Light background for card contrast
        child: Center(
          child: FadeTransition(
            opacity: AlwaysStoppedAnimation(0.8), // Create an Animation with a constant value
            child: Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Large lock icon
                    Icon(
                      Icons.lock,
                      size: 120,
                      color: Colors.lightBlue[700], // Teal icon color
                    ),
                    SizedBox(height: 16.0),
                    // Premium version text
                    Text(
                      'This feature is only in the premium version',
                      style: TextStyle(fontSize: 18, color: Colors.black87), // Custom text color
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.0),
                    // Purchase Premium button
                    ElevatedButton(
                      onPressed: () {
                        // Implement logic to navigate to the premium purchase screen
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.lightBlueAccent, backgroundColor: Colors.lightBlue[700], // White text color
                      ),
                      child: Text('Purchase Premium'),
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