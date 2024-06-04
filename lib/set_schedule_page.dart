import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';

class SetSchedulePage extends StatefulWidget {
  @override
  _SetSchedulePageState createState() => _SetSchedulePageState();
}

class _SetSchedulePageState extends State<SetSchedulePage> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  List<EventItem> events = [];

  @override
  void initState() {
    super.initState();
    _initNotifications();
    _loadEvents(); // Load events when the page initializes
    tz.initializeTimeZones(); // Initialize timezone data
  }

  void _initNotifications() {
    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  // Load events from storage
  void _loadEvents() async {
    final savedEvents = await _loadSavedEvents();
    if (savedEvents != null) {
      setState(() {
        events = savedEvents;
      });
    }
  }

  // Save events to storage
  Future<void> _saveEvents() async {
    final jsonEvents = events.map((event) => event.toJson()).toList();
    final jsonString = jsonEncode(jsonEvents);
    await DefaultCacheManager()
        .putFile('events.json', utf8.encode(jsonString));
  }

  // Load events from storage
  Future<List<EventItem>> _loadSavedEvents() async {
    try {
      final file = await DefaultCacheManager().getSingleFile('events.json');
      if (file == null) {
        return [];
      }
      final jsonString = utf8.decode(await file.readAsBytes());
      final List<dynamic> jsonEvents = jsonDecode(jsonString);
      return jsonEvents.map((json) => EventItem.fromJson(json)).toList();
    } catch (e) {
      print("Error loading events: $e");
      return [];
    }
  }

  Future<void> _addEvent(DateTime scheduledDate, String description) async {
    final EventItem event =
    EventItem(scheduledDate: scheduledDate, description: description);
    setState(() {
      events.add(event);
    });
    await _scheduleNotification(event);
    await _saveEvents(); // Save events when a new event is added
  }

  Future<void> _editEvent(
      int index, DateTime scheduledDate, String description) async {
    final EventItem updatedEvent =
    EventItem(scheduledDate: scheduledDate, description: description);
    setState(() {
      events[index] = updatedEvent;
    });
    await _saveEvents(); // Save events when an event is edited
  }

  Future<void> _deleteEvent(int index) async {
    setState(() {
      events.removeAt(index);
    });
    await _saveEvents(); // Save events when an event is deleted
  }

  Future<void> _scheduleNotification(EventItem event) async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id',
      'Scheduled notifications',
      channelDescription: 'Scheduled notifications',
      importance: Importance.max,
      priority: Priority.high,
      icon: 'app_icon',
      largeIcon: DrawableResourceAndroidBitmap('app_icon'),
    );
    final NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      events.length, // Use a unique id for each notification
      'Scheduled Event',
      'It is time for ${event.description}',
      tz.TZDateTime.from(event.scheduledDate, tz.local),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  @override
  void dispose() {
    _saveEvents(); // Save events when leaving the page
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Schedule Page'),
        backgroundColor: Colors.lightBlueAccent,
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
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () => _addEventDialog(context),
              child: Text('Add Event'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.lightBlueAccent,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  return Card(
                    elevation: 4.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    color: Colors.greenAccent, // Changing card color to green
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListTile(
                      title: Text(
                        DateFormat.yMMMd().add_jm().format(event.scheduledDate),
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Changing text color to black
                        ),
                      ),
                      subtitle: Text(
                        event.description,
                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.orange),
                            onPressed: () =>
                                _editEventDialog(context, index, event),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () => _deleteEvent(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addEventDialog(BuildContext context) async {
    DateTime selectedDateTime = DateTime.now();
    TextEditingController descriptionController = TextEditingController();

    await showDialog(
        context: context,
        builder: (BuildContext context) {
      return AlertDialog(
          title: Text('Add Event'),
    content: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
    ElevatedButton(
    onPressed: () async {
    final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDateTime,
    firstDate: DateTime(2022),
    lastDate: DateTime(2025),
    );
    if (picked != null) {
    final TimeOfDay? selectedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.fromDateTime(selectedDateTime),
    );
    if (selectedTime != null) {
      setState(() {
        selectedDateTime = DateTime(
          picked.year,
          picked.month,
          picked.day,
          selectedTime.hour,
          selectedTime.minute,
        );
      });
    }
    }
    },
      child: Text(
        'Select Date & Time: ${DateFormat.yMMMd().add_jm().format(selectedDateTime)}',
      ),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.lightBlueAccent,
      ),
    ),
      TextField(
        controller: descriptionController,
        decoration: InputDecoration(labelText: 'Event Description'),
      ),
    ],
    ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              _addEvent(selectedDateTime, descriptionController.text);
              Navigator.of(context).pop();
            },
            child: Text('Add'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.lightBlueAccent,
            ),
          ),
        ],
      );
        },
    );
  }

  Future<void> _editEventDialog(
      BuildContext context, int index, EventItem event) async {
    DateTime selectedDateTime = event.scheduledDate;
    TextEditingController descriptionController =
    TextEditingController(text: event.description);

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Event'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDateTime,
                    firstDate: DateTime(2022),
                    lastDate: DateTime(2025),
                  );
                  if (picked != null) {
                    final TimeOfDay? selectedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(selectedDateTime),
                    );
                    if (selectedTime != null) {
                      setState(() {
                        selectedDateTime = DateTime(
                          picked.year,
                          picked.month,
                          picked.day,
                          selectedTime.hour,
                          selectedTime.minute,
                        );
                      });
                    }
                  }
                },
                child: Text(
                  'Select Date & Time: ${DateFormat.yMMMd().add_jm().format(selectedDateTime)}',
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.lightBlueAccent,
                ),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Event Description'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _editEvent(index, selectedDateTime, descriptionController.text);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.lightBlueAccent,
              ),
            ),
          ],
        );
      },
    );
  }
}

class EventItem {
  final DateTime scheduledDate;
  final String description;

  EventItem({required this.scheduledDate, required this.description});

  factory EventItem.fromJson(Map<String, dynamic> json) {
    return EventItem(
      scheduledDate: DateTime.parse(json['scheduledDate']),
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'scheduledDate': scheduledDate.toIso8601String(),
      'description': description,
    };
  }
}

void main() {
  runApp(MaterialApp(
    home: SetSchedulePage(),
  ));
}

