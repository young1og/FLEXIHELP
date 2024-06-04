import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkMode = false;
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  double _volume = 0.5;
  String _language = 'English';
  Color _themeColor = Colors.lightBlueAccent;
  double _fontSize = 14.0;

  List<String> _languages = ['English', 'Українська', 'Español'];

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkMode = prefs.getBool('darkMode') ?? false;
      _pushNotifications = prefs.getBool('pushNotifications') ?? true;
      _emailNotifications = prefs.getBool('emailNotifications') ?? true;
      _volume = prefs.getDouble('volume') ?? 0.5;
      _language = prefs.getString('language') ?? 'English';
      if (!_languages.contains(_language)) {
        _language = 'English'; // Set to default if the saved value is not in the list
      }
      _themeColor = Color(prefs.getInt('themeColor') ?? Colors.lightBlueAccent.value);
      _fontSize = prefs.getDouble('fontSize') ?? 14.0;
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', _darkMode);
    await prefs.setBool('pushNotifications', _pushNotifications);
    await prefs.setBool('emailNotifications', _emailNotifications);
    await prefs.setDouble('volume', _volume);
    await prefs.setString('language', _language);
    await prefs.setInt('themeColor', _themeColor.value);
    await prefs.setDouble('fontSize', _fontSize);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: _themeColor,
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
        child: ListView(
          children: [
            ListTile(
              title: Text(
                'Audio Playback Volume',
                style: TextStyle(color: Colors.black87),
              ),
              trailing: SizedBox(
                width: 150,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.volume_up, color: Colors.black87),
                    SizedBox(width: 8),
                    Expanded(
                      child: Slider(
                        value: _volume,
                        min: 0,
                        max: 1,
                        onChanged: (value) {
                          setState(() {
                            _volume = value;
                          });
                          _saveSettings();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Dark Mode',
                style: TextStyle(color: Colors.black87),
              ),
              trailing: Switch(
                value: _darkMode,
                onChanged: (newValue) {
                  setState(() {
                    _darkMode = newValue;
                  });
                  _saveSettings();
                },
              ),
            ),
            ListTile(
              title: Text(
                'Push Notifications',
                style: TextStyle(color: Colors.black87),
              ),
              trailing: Switch(
                value: _pushNotifications,
                onChanged: (newValue) {
                  setState(() {
                    _pushNotifications = newValue;
                  });
                  _saveSettings();
                },
              ),
            ),
            ListTile(
              title: Text(
                'Language',
                style: TextStyle(color: Colors.black87),
              ),
              trailing: SizedBox(
                width: 150,
                child: DropdownButton<String>(
                  value: _language,
                  onChanged: (String? newValue) {
                    setState(() {
                      _language = newValue!;
                    });
                    _saveSettings();
                  },
                  items: _languages.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Email Notifications',
                style: TextStyle(color: Colors.black87),
              ),
              trailing: Switch(
                value: _emailNotifications,
                onChanged: (newValue) {
                  setState(() {
                    _emailNotifications = newValue;
                  });
                  _saveSettings();
                },
              ),
            ),
            ListTile(
              title: Text(
                'Theme Color',
                style: TextStyle(color: Colors.black87),
              ),
              trailing: IconButton(
                icon: Icon(Icons.color_lens, color: Colors.black87),
                onPressed: () async {
                  Color? newColor = await showDialog(
                    context: context,
                    builder: (context) => ColorPickerDialog(currentColor: _themeColor),
                  );
                  if (newColor != null) {
                    setState(() {
                      _themeColor = newColor;
                    });
                    _saveSettings();
                  }
                },
              ),
            ),
            ListTile(
              title: Text(
                'Font Size',
                style: TextStyle(color: Colors.black87),
              ),
              trailing: SizedBox(
                width: 150,
                child: Slider(
                  value: _fontSize,
                  min: 10,
                  max: 24,
                  onChanged: (value) {
                    setState(() {
                      _fontSize = value;
                    });
                    _saveSettings();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorPickerDialog extends StatefulWidget {
  final Color currentColor;

  ColorPickerDialog({required this.currentColor});

  @override
  _ColorPickerDialogState createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  Color _selectedColor;

  _ColorPickerDialogState() : _selectedColor = Colors.lightBlueAccent;

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.currentColor;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Theme Color'),
      content: SingleChildScrollView(
        child: BlockPicker(
          pickerColor: _selectedColor,
          onColorChanged: (color) {
            setState(() {
              _selectedColor = color;
            });
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(_selectedColor);
          },
          child: Text('Select'),
        ),
      ],
    );
  }
}
