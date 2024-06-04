import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  DateTime selectedDate = DateTime.now();
  TextEditingController noteTextController = TextEditingController();
  List<Note> notes = [];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _addNote() {
    String noteText = noteTextController.text;
    if (noteText.isNotEmpty) {
      setState(() {
        notes.add(Note(
          date: selectedDate,
          text: noteText,
        ));
      });
      noteTextController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes Page'),
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
            TextField(
              controller: noteTextController,
              decoration: InputDecoration(
                hintText: 'Enter your note',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Date: ${DateFormat.yMMMd().format(selectedDate)}',
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Select Date'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _addNote,
              child: Text('Add Note'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.lightBlueAccent,
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return Card(
                    elevation: 4.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    color: Colors.greenAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListTile(
                      title: Text(
                        DateFormat.yMMMd().format(note.date),
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        note.text,
                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
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
}

class Note {
  final DateTime date;
  final String text;

  Note({
    required this.date,
    required this.text,
  });
}
