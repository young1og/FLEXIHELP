import 'package:flutter/material.dart';

import 'MedicationEvent.dart';

class MedicationSchedulePage extends StatefulWidget {
  @override
  _MedicationSchedulePageState createState() =>
      _MedicationSchedulePageState();
}

class _MedicationSchedulePageState extends State<MedicationSchedulePage> {
  final TextEditingController medicationNameController =
  TextEditingController();
  final TextEditingController soundNameController = TextEditingController();
  final TextEditingController textController = TextEditingController();
  int selectedQuantity = 1;
  List<MedicationEvent> events = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.lightBlueAccent, // установите цвет фона Scaffold
        appBar: AppBar(
          title: Text('Medication Schedule'),
          backgroundColor: Colors.lightBlueAccent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Medication Schedule',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  'Add the name of medication',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                TextField(
                  controller: medicationNameController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Enter medication name',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  'Quantity of pills',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Row(
                  children: [
                    DropdownButton<int>(
                      value: selectedQuantity,
                      onChanged: (int? value) {
                        if (value != null) {
                          setState(() {
                            selectedQuantity = value;
                          });
                        }
                      },
                      items: List.generate(10, (index) => index + 1)
                          .map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(
                            value.toString(),
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                      dropdownColor: Colors.white,
                    ),
                    SizedBox(width: 8.0),
                    Icon(
                      Icons.medication,
                      size: 30,
                      color: Colors.white,
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  'Add the sound you would like to hear',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                TextField(
                  controller: soundNameController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Enter sound name',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Add the text you would like to be voiced',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                TextField(
                  controller: textController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Enter text',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          _saveEvent();
                          _clearInputFields();
                        },
                        child: Text('Save Event'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.lightBlueAccent,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          _navigateToViewPage(context);
                        },
                        child: Text('View Events'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.lightBlueAccent,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveEvent() {
    setState(() {
      events.add(
        MedicationEvent(
          medication: medicationNameController.text,
          quantity: selectedQuantity,
          sound: soundNameController.text,
          text: textController.text,
        ),
      );
    });
  }

  void _clearInputFields() {
    medicationNameController.clear();
    soundNameController.clear();
    textController.clear();
    selectedQuantity = 1;
  }

  void _navigateToViewPage(BuildContext context) {
    Navigator.push(context,
      MaterialPageRoute(
        builder: (context) => ViewEventsPage(
          events: events,
          onEdit: (index) => _navigateToEditPage(context, index),
          onDelete: _deleteEvent,
        ),
      ),
    );
  }

  void _navigateToEditPage(BuildContext context, int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditEventPage(event: events[index]),
      ),
    );

    if (result != null) {
      setState(() {
        events[index] = result;
      });
    }
  }

  void _deleteEvent(int index) {
    setState(() {
      events.removeAt(index);
    });
  }
}


