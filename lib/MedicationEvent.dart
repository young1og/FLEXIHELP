import 'package:flexihelp/AvatarSelectionPage.dart';
import 'package:flexihelp/FaqPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MedicationEvent {
  String medication;
  int quantity;
  String sound;
  String text;

  MedicationEvent({
    required this.medication,
    required this.quantity,
    required this.sound,
    required this.text,
  });
}

class EditEventPage extends StatefulWidget {
  final MedicationEvent event;

  EditEventPage({required this.event});

  @override
  _EditEventPageState createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {
  TextEditingController medicationNameController = TextEditingController();
  TextEditingController soundNameController = TextEditingController();
  TextEditingController textController = TextEditingController();
  int selectedQuantity = 1;

  @override
  void initState() {
    super.initState();
    medicationNameController.text = widget.event.medication;
    soundNameController.text = widget.event.sound;
    textController.text = widget.event.text;
    selectedQuantity = widget.event.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Event'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Edit Medication Event',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16.0),
                  Text('Medication Name:'),
                  TextField(
                    controller: medicationNameController,
                  ),
                  SizedBox(height: 16.0),
                  Text('Quantity of Pills:'),
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
                        child: Text(value.toString()),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16.0),
                  Text('Sound Name:'),
                  TextField(
                    controller: soundNameController,
                  ),
                  SizedBox(height: 16.0),
                  Text('Text to be Voiced:'),
                  TextField(
                    controller: textController,
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      _saveEditedEvent();
                      Navigator.pop(context, widget.event);
                    },
                    child: Text('Save Changes'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _saveEditedEvent() {
    widget.event.medication = medicationNameController.text;
    widget.event.quantity = selectedQuantity;
    widget.event.sound = soundNameController.text;
    widget.event.text = textController.text;
  }
}


class ViewEventsPage extends StatelessWidget {
  final List<MedicationEvent> events;
  final Function(int) onEdit;
  final Function(int) onDelete;

  ViewEventsPage(
      {required this.events, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Events'),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          return ListTile(

            tileColor: Color.fromRGBO(255, 255, 255, 1.0),
            title: Text (events[index].medication,
              style: TextStyle(color:Colors.black) ,),
            trailing: IconButton(
              icon: Icon(
                Icons.delete_sweep,
                color: Color.fromRGBO(255, 0, 0, 1.0), ), onPressed: () {  onDelete(index); },
            ),
            subtitle: Text('Quantity: ${events[index].quantity}'),
            onTap: () {
              // Вызываем onEdit при нажатии на элемент списка
              onEdit(index);
            },
          );
        },
      ),
    );
  }


  void _navigateToPage(BuildContext context, Widget page) {
    if (page is FaqPage) {
      // For HelpPage, use MaterialPageRoute without transition animation
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      );
    } else if (page is AvatarSelectionPage) {
      // For AvatarSelectionPage, use MaterialPageRoute with a custom route transition
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween = Tween(begin: begin, end: end).chain(
                CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(position: offsetAnimation, child: child);
          },
        ),
      );
    } else {
      // For other pages, use default MaterialPageRoute with animation
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      );
    }
  }


  void setState(Null Function() param0) {
  }
}