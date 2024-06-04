import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flexihelp/AddCirclePage.dart';
import 'package:flexihelp/AvatarSelectionPage.dart';
import 'package:flexihelp/ConnectVAPage.dart';
import 'package:flexihelp/DrawingMoodTrackerPage.dart';
import 'package:flexihelp/FaqPage.dart';
import 'package:flexihelp/MedicationShedulPage.dart';
import 'package:flexihelp/ProgressTrackingPage.dart';
import 'package:flexihelp/PsyhologistHepPage.dart';
import 'package:flexihelp/SetNotificationPage.dart';
import 'package:flexihelp/SettingsPage.dart';
import 'package:flexihelp/set_schedule_page.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
        backgroundColor: Colors.lightBlueAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () {
              _navigateToPage(context, AddCirclePage());
            },
            tooltip: 'Add Circle',
          ),
          IconButton(
            icon: Icon(Icons.settings_outlined),
            onPressed: () {
              _navigateToPage(context, SettingsPage());
            },
            tooltip: 'Settings',
          ),
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              _navigateToPage(context, FaqPage());
            },
            tooltip: 'Help',
          ),
        ],
      ),
      body: Container(
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
        padding: EdgeInsets.all(12.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 12.0,
          crossAxisSpacing: 12.0,
          children: [
            _buildRoundedButton(context, 'Medication Schedule', Icons.access_alarm, () {
              _navigateToPage(context, MedicationSchedulePage());
            }),
            _buildRoundedButton(context, 'Set Schedule', Icons.schedule, () {
              _navigateToPage(context, SetSchedulePage());
            }),
            _buildRoundedButton(context, 'Notes Page', Icons.edit_note_sharp, () {
              _navigateToPage(context, NotesPage());
            }),
            _buildRoundedButton(context, 'Connect Video or Audio', Icons.mic, () {
              _navigateToPage(context, ConnectVideoAudioPage());
            }),
            _buildRoundedButtonWithDollar(context, 'Drawing Mood Tracker AI', Icons.brush, () {
              _navigateToPage(context, DrawingMoodTrackerPage());
            }),
            _buildRoundedButtonWithDollar(context, 'Mobile Psychologist Helper AI', Icons.phone_android, () {
              _navigateToPage(context, PsychologistHelperPage());
            }),
            _buildRoundedButtonWithDollar(context, 'Choosing an Avatar', Icons.person, () {
              _navigateToPage(context, AvatarSelectionPage());
            }),
            _buildRoundedButton(context, 'Progress Tracking', Icons.timeline, () {
              _navigateToPage(context, ProgressTrackingPage());


            }),
          ],
        ),
      ),
    );
  }

  Widget _buildRoundedButton(BuildContext context, String text, IconData icon, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.lightBlueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 4.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 32,
            color: Colors.white,
          ),
          SizedBox(height: 6.0),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoundedButtonWithDollar(BuildContext context, String text, IconData icon, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.lightBlueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 4.0,
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 32,
                color: Colors.white,
              ),
              SizedBox(height: 6.0),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(6.0),
            child: Text(
              '\$',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      LinearSales(0, 5),
      LinearSales(1, 25),
      LinearSales(2, 100),
      LinearSales(3, 75),
    ];

    return [
      charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
