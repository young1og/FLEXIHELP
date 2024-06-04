import 'package:flutter/material.dart';

class AvatarSelectionPage extends StatefulWidget {
  @override
  _AvatarSelectionPageState createState() => _AvatarSelectionPageState();
}

class _AvatarSelectionPageState extends State<AvatarSelectionPage> {
  int _selectedAvatarIndex = -1; // Для отслеживания выбранного аватара

  final List<String> avatarImages = [
    'assets/avatar1.png',
    'assets/avatar2.png',
    'assets/avatar3.png',
    'assets/avatar4.png',
    'assets/avatar5.png',
    'assets/avatar6.png',
    'assets/avatar7.png',
    'assets/avatar8.png',
    'assets/avatar9.png',
    // Добавьте пути к другим аватаркам здесь
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Your Avatar'),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Описание выбора аватара
            Text(
              'Select your avatar',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 32.0),
            // Список круглых аватаров с возможностью пролистывания
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: avatarImages.length,
                itemBuilder: (context, index) {
                  return _buildAvatarAvatar(context, index);
                },
              ),
            ),
            SizedBox(height: 32.0),
            // Кнопка для выбора аватара
            ElevatedButton(
              onPressed: () {
                if (_selectedAvatarIndex != -1) {
                  String selectedAvatar = avatarImages[_selectedAvatarIndex];
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Selected avatar: $selectedAvatar'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please select an avatar first.'),
                    ),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'Select Avatar',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Виджет для отображения одного аватара
  Widget _buildAvatarAvatar(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAvatarIndex = index;
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: _selectedAvatarIndex == index ? Colors.greenAccent : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(avatarImages[index]), // Указывайте путь к ассету напрямую
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Avatar ${index + 1}',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
