import 'package:flexihelp/MedicationEvent.dart';
import 'package:flutter/material.dart';

List<MedicationEvent> events = [];

class EventItem {
  final TimeOfDay time;
  final String day;
  final String description;

  EventItem({
    required this.time,
    required this.day,
    required this.description,
  });

}
