import 'package:flutter/material.dart';

class BattleScreen extends StatefulWidget {
  @override
  _BattleScreenState createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  int _selectedCardIndex = -1;

  void _showAnswerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Your Answer'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('A. HTML Code Example'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('B. CSS Code Example'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('C. JavaScript Code Example'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF141F23),
      appBar: AppBar(
        backgroundColor: Color(0xFF334A56),
        title: Text(
          'Facing off against User 2',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite, color: Color(0xFF25F277), size: 30),
                      SizedBox(width: 10),
                      Icon(Icons.favorite, color: Color(0xFF25F277), size: 30),
                      SizedBox(width: 10),
                      Icon(Icons.favorite, color: Color(0xFFBDBDBD), size: 30),
                    ],
                  ),
                  SizedBox(height: 20),
                  buildCard(4),
                  Container(
                    width: double.infinity,
                    height: 170,
                    decoration: BoxDecoration(
                      color: Color(0xFF334A56),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Problem: You are designing a webpage, and you need to create a blue button with white text that says "Submit". The button should have rounded corners with a radius of 10px. How would you write the correct HTML and CSS code to achieve this?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: _showAnswerDialog,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF25F277),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Answer',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 200), // Add padding to avoid overlapping
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Color(0xFF25F277),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildCard(0),
                  buildCard(1),
                  buildCard(2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard(int index) {
    bool isSelected = index == _selectedCardIndex;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCardIndex = isSelected ? -1 : index;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: 100,
        height: 150,
        decoration: BoxDecoration(
          color: Color(0xFF7594A4),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Color(0xFFFFCE64) : Color(0xFF22333C),
            width: 4,
          ),
        ),
        child: Transform.translate(
          offset: Offset(0, isSelected ? -5.0 : 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 100,
                height: 10,
                margin: EdgeInsets.only(bottom: 5),
                child: LinearProgressIndicator(
                  value: 0.6,
                  backgroundColor: Color(0xFF8BE0FF),
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFFCE64)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
