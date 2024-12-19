import 'package:flutter/material.dart';

class CharacterGalleryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF141F23),
      appBar: AppBar(
        backgroundColor: Color(0xFF334A56),
        title: Text(
          'Collection',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: 6,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            return buildCard(index);
          },
        ),
      ),
    );
  }

  Widget buildCard(int index) {
    // Sample images for each card (replace with your own image URLs or assets)
    List<String> cardImages = [
      'assets/card1.png',
      'assets/card2.png',
      'assets/card3.png',
      'assets/card4.png',
      'assets/card5.png',
      'assets/card6.png',
    ];

    // Define border colors for each card
    List<Color> borderColors = [
      Colors.yellow,
      Colors.purple,
      Colors.red,
      Colors.blue,
      Colors.red,
      Colors.lightBlue,
    ];

    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF7594A4),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: borderColors[index],
          width: 4,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                cardImages[index],
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          SizedBox(height: 5),
          Container(
            width: 80,
            height: 10,
            decoration: BoxDecoration(
              color: Color(0xFF22333C),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ],
      ),
    );
  }
}
