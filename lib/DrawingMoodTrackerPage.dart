import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawingMoodTrackerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drawing Mood Tracker AI'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.secondary.withOpacity(0.7),
              Theme.of(context).colorScheme.secondary,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Add a large lock icon
              Icon(
                Icons.lock,
                size: 120,
                color: Colors.white,
              ),
              SizedBox(height: 16.0),
              // Add a text indicating premium feature
              Text(
                'This feature is only in the premium version',
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.0),
              // Add a button for purchasing premium
              ElevatedButton(
                onPressed: () {
                  // Implement the logic to navigate to the premium purchase screen
                },
                child: Text('Purchase Premium'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}